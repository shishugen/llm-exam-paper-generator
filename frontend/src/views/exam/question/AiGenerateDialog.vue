<template>
  <el-dialog v-model="visible" title="AI 辅助出题" width="1100px" top="5vh" append-to-body @close="emit('close')">
    <div class="ai-wrap">
      <!-- ===== 左边：出题参数 ===== -->
      <div class="ai-left">
        <el-form :model="form" label-width="76px">
          <el-form-item label="知识点" required>
            <el-select v-model="form.knowledgeId" filterable placeholder="请选择知识点" style="width:100%">
              <el-option v-for="k in knowledgeList" :key="k.id" :label="k.name" :value="k.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="题型">
            <el-select v-model="form.type" style="width:100%">
              <el-option v-for="d in exam_question_type" :key="d.value" :label="d.label" :value="d.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="难度">
            <el-select v-model="form.difficulty" style="width:100%">
              <el-option v-for="d in exam_difficulty" :key="d.value" :label="d.label" :value="d.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="生成数量">
            <el-input-number v-model="form.count" :min="1" :max="10" />
          </el-form-item>
        </el-form>

        <el-button type="primary" class="gen-btn" :loading="loading" @click="doPreview">
          {{ loading ? 'AI 正在出题…' : '生成预览' }}
        </el-button>

        <div class="left-tip">
          点「生成预览」会实时调用大模型接口，一般 5～20 秒，题目多或模型忙时可能要 1 分钟以上，
          最长等 2 分钟。生成结果先在右边看全文，确认没问题再点保存入库；不满意可重新生成。
          单次最多 10 道。
        </div>
      </div>

      <!-- ===== 右边：完整题目预览 ===== -->
      <div class="ai-right">
        <div class="right-head">
          <span>生成结果（可直接修改）</span>
          <span v-if="generated" class="cnt">
            共 {{ previewResults.length }} 道，有效 {{ validCount }} 道<template v-if="invalidCount > 0">，无效 {{ invalidCount }} 道</template>
          </span>
        </div>
        <div class="right-body" v-loading="loading" element-loading-text="AI 正在出题，请稍候…">
          <el-empty v-if="!generated" description="左侧填好参数，点「生成预览」后这里显示完整的题目、选项、答案和解析" :image-size="80" />
          <div v-for="(q, i) in previewResults" :key="i" class="q-card" :class="{ 'q-invalid': q.status === '-1' }">
            <div class="q-top">
              <span class="q-no">{{ i + 1 }}</span>
              <el-tag size="small" :type="q.status === '-1' ? 'info' : 'success'">
                {{ q.status === '-1' ? '无效' : '有效' }}
              </el-tag>
              <el-tag size="small" type="info" class="ml6">{{ typeMap[q.type] || '—' }}</el-tag>
              <el-tag size="small" type="info" class="ml6">{{ diffMap[q.difficulty] || '—' }}</el-tag>
              <el-input-number v-if="q.editing" v-model="q.score" :min="1" :max="100" size="small" class="q-score-input" />
              <span v-else class="q-score">{{ q.score ?? '—' }} 分</span>
              <el-button v-if="q.status !== '-1'" link type="primary" size="small" class="edit-btn" @click="q.editing = !q.editing">
                {{ q.editing ? '完成' : '编辑' }}
              </el-button>
            </div>
            <div class="q-stem">
              <el-input v-if="q.editing" v-model="q.stem" type="textarea" :rows="2" placeholder="题干" />
              <span v-else>{{ q.stem || '（无题干）' }}</span>
            </div>
            <div v-if="q.optionList && q.optionList.length > 0" class="q-options">
              <div v-for="o in q.optionList" :key="o.key" class="q-option">
                <b>{{ o.key }}.</b>
                <el-input v-if="q.editing" v-model="o.value" size="small" />
                <span v-else>{{ o.value }}</span>
              </div>
            </div>
            <div class="q-line">
              <b>答案：</b>
              <el-input v-if="q.editing" v-model="q.answer" size="small" class="ans-input" />
              <span v-else class="ans">{{ q.answer || '—' }}</span>
            </div>
            <div v-if="q.editing || q.analysis" class="q-line">
              <b>解析：</b>
              <el-input v-if="q.editing" v-model="q.analysis" type="textarea" :rows="2" placeholder="解析" />
              <span v-else>{{ q.analysis }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button :loading="loading" @click="doPreview">重新生成</el-button>
      <el-button type="primary" :loading="saving" :disabled="validCount === 0" @click="doSave">
        保存有效题目（{{ validCount }} 道）
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup name="AiGenerateDialog">
import { listKnowledge } from "@/api/exam/knowledge"
import { previewQuestions, saveGenerated } from "@/api/exam/question"

const emit = defineEmits(['close', 'success'])
const { proxy } = getCurrentInstance()
const { exam_question_type, exam_difficulty } = useDict('exam_question_type', 'exam_difficulty')

const visible = ref(true)
const loading = ref(false)
const saving = ref(false)
const knowledgeList = ref([])
const form = reactive({ knowledgeId: null, type: '1', difficulty: '2', count: 3 })

// 预览结果
const generated = ref(false)
const previewResults = ref([]) // 原始返回，含无效题
const validCount = ref(0)
const invalidCount = ref(0)

const typeMap = { '1':'单选','2':'多选','3':'判断','4':'简答','5':'综合' }
const diffMap = { '1':'容易','2':'中等','3':'较难','4':'困难' }

listKnowledge({ pageNum: 1, pageSize: 200 }).then(res => { knowledgeList.value = res.rows || [] })

function doPreview() {
  if (!form.knowledgeId) {
    proxy.$modal.msgWarning('请先选择知识点')
    return
  }
  loading.value = true
  previewQuestions(form).then(res => {
    const list = res.data || []
    for (const q of list) {
      q.optionList = parseOptions(q.options)
      q.editing = false
    }
    previewResults.value = list
    validCount.value = previewResults.value.filter(q => q.status !== '-1').length
    invalidCount.value = previewResults.value.filter(q => q.status === '-1').length
    generated.value = true
    if (previewResults.value.length === 0) {
      proxy.$modal.msgWarning('AI 没有返回题目，请重试；多次失败可先看「AI 调用日志」里的错误信息')
    }
  }).finally(() => { loading.value = false })
}

function doSave() {
  const questions = previewResults.value.filter(q => q.status !== '-1')
  for (const q of questions) {
    if (q.optionList && q.optionList.length > 0) {
      q.options = JSON.stringify(q.optionList)
    }
  }
  const payload = {
    knowledgeId: form.knowledgeId,
    type: form.type,
    difficulty: form.difficulty,
    questions: questions
  }
  saving.value = true
  saveGenerated(payload).then(res => {
    proxy.$modal.msgSuccess(res.msg || `已保存 ${validCount.value} 道题`)
    emit('success')
    generated.value = false
    previewResults.value = []
    validCount.value = 0
    invalidCount.value = 0
    visible.value = false
  }).finally(() => { saving.value = false })
}

// options 在库里是 JSON 字符串，转成数组渲染
function parseOptions(jsonStr) {
  try {
    return JSON.parse(jsonStr) || []
  } catch (e) {
    return []
  }
}
</script>

<style scoped>
:deep(.el-dialog) { max-width: 96vw; }

.ai-wrap { display: flex; gap: 16px; height: 62vh; min-height: 420px; }

.ai-left { width: 320px; flex: none; }
.gen-btn { width: 100%; margin-top: 4px; }
.left-tip { margin-top: 12px; font-size: 12px; line-height: 1.7; color: #909399; }

.ai-right { flex: 1; min-width: 0; display: flex; flex-direction: column; }
.right-head {
  display: flex; align-items: center; justify-content: space-between;
  font-size: 14px; font-weight: 600; color: #303133; padding: 0 2px 8px;
}
.right-head .cnt { font-weight: normal; font-size: 12px; color: #909399; }
.right-body {
  flex: 1; overflow-y: auto; padding: 12px;
  border: 1px solid #ebeef5; border-radius: 4px; background: #fafafa;
}

.q-card {
  background: #fff; border: 1px solid #ebeef5; border-radius: 4px;
  padding: 12px 14px; margin-bottom: 10px;
}
.q-card:last-child { margin-bottom: 0; }
.q-invalid { background: #fafafa; opacity: 0.75; }
.q-top { display: flex; align-items: center; margin-bottom: 8px; }
.q-no {
  display: inline-block; width: 20px; height: 20px; line-height: 20px; text-align: center;
  background: #409eff; color: #fff; border-radius: 50%; font-size: 12px; margin-right: 8px;
}
.q-score { margin-left: auto; font-size: 12px; color: #909399; }
.q-stem { font-size: 14px; line-height: 1.8; color: #303133; white-space: pre-wrap; word-break: break-word; }
.q-options { margin-top: 8px; }
.q-option { display: flex; align-items: center; gap: 6px; margin-bottom: 4px; font-size: 13px; color: #606266; }
.q-option b { flex: none; }
.q-line { display: flex; align-items: flex-start; gap: 6px; margin-top: 8px; font-size: 13px; color: #606266; white-space: pre-wrap; word-break: break-word; }
.q-line b { flex: none; line-height: 32px; }
.q-line > span { line-height: 32px; }
.q-line .ans { color: #67c23a; font-weight: 600; }
.ans-input { width: 220px; }
.q-score-input { width: 110px; margin-left: auto; }
.edit-btn { margin-left: 8px; flex: none; }
.ml6 { margin-left: 6px; }
</style>
