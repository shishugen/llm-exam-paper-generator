<template>
  <el-dialog v-model="visible" title="一键组卷" width="1120px" top="4vh" append-to-body @close="emit('close')">
    <div class="cz-wrap">
      <!-- ===== 左边：组卷参数 ===== -->
      <div class="cz-left">
        <el-form :model="form" label-width="88px">
          <el-form-item label="课程" required>
            <el-select v-model="form.courseId" placeholder="请选择课程" style="width: 100%">
              <el-option v-for="c in courses" :key="c.id" :label="c.courseName" :value="c.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="章节范围">
            <el-select v-model="form.chapterIds" multiple filterable collapse-tags collapse-tags-tooltip
              :disabled="!form.courseId" placeholder="不选=整门课程，可多选" style="width: 100%">
              <el-option v-for="ch in chapters" :key="ch.id" :label="ch.name" :value="ch.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="试卷名称" required>
            <el-input v-model="form.title" placeholder="例如：数据库原理与应用 期末测验（B 卷）" />
          </el-form-item>
          <el-form-item label="总分">
            <el-input-number v-model="form.totalScore" :min="10" :max="150" />
          </el-form-item>

          <el-divider content-position="left">题型配比（题数）</el-divider>
          <el-row>
            <el-col :span="12"><el-form-item label="单选" label-width="50px"><div class="avail-row"><el-input-number v-model="form.t1" :min="0" :max="maxOf('t1')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.t1 || 0 }}</span></div></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="多选" label-width="50px"><div class="avail-row"><el-input-number v-model="form.t2" :min="0" :max="maxOf('t2')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.t2 || 0 }}</span></div></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="判断" label-width="50px"><div class="avail-row"><el-input-number v-model="form.t3" :min="0" :max="maxOf('t3')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.t3 || 0 }}</span></div></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="简答" label-width="50px"><div class="avail-row"><el-input-number v-model="form.t4" :min="0" :max="maxOf('t4')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.t4 || 0 }}</span></div></el-form-item></el-col>
          </el-row>

          <el-divider content-position="left">难度分布（题数）</el-divider>
          <el-row>
            <el-col :span="12"><el-form-item label="容易" label-width="50px"><div class="avail-row"><el-input-number v-model="form.d1" :min="0" :max="maxOf('d1')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.d1 || 0 }}</span></div></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="中等" label-width="50px"><div class="avail-row"><el-input-number v-model="form.d2" :min="0" :max="maxOf('d2')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.d2 || 0 }}</span></div></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="较难" label-width="50px"><div class="avail-row"><el-input-number v-model="form.d3" :min="0" :max="maxOf('d3')" size="small" style="width: 84px" /><span class="avail-text">可用 {{ available.d3 || 0 }}</span></div></el-form-item></el-col>
          </el-row>

          <el-form-item label="覆盖率目标">
            <el-input-number v-model="form.coverage" :min="0" :max="100" />
            <span class="ml8 tip-text">%，目标值仅供参考</span>
          </el-form-item>
        </el-form>

        <div class="avail-total">当前范围共 {{ available.total || 0 }} 道可用题（只算已通过审核的）</div>
        <el-button type="primary" class="gen-btn" :loading="loading" @click="doPreview">
          {{ loading ? '正在抽题…' : '生成预览' }}
        </el-button>
        <div class="left-tip">
          只从「已通过」审核的题目里随机抽。生成后先在右边浏览题目，确认没问题再点保存入库。
        </div>
      </div>

      <!-- ===== 右边：题目预览 ===== -->
      <div class="cz-right">
        <div class="right-head">
          <span>抽题结果（完整题目）</span>
          <span v-if="previewed" class="cnt">
            共 {{ result.questions.length }} 题，每题约 {{ result.perScore }} 分
          </span>
        </div>
        <el-alert v-if="result.warning" type="warning" :closable="false" show-icon
          :title="result.warning" class="mb8" />
        <div class="right-body" v-loading="loading" element-loading-text="正在抽题…">
          <el-empty v-if="!previewed" description="左侧填好参数，点「生成预览」后这里列出抽到的题目、选项、答案和解析" :image-size="80" />
          <div v-for="(q, i) in result.questions" :key="q.id" class="q-card">
            <div class="q-top">
              <span class="q-no">{{ i + 1 }}</span>
              <dict-tag :options="exam_question_type" :value="q.type" />
              <span class="ml6"><dict-tag :options="exam_difficulty" :value="q.difficulty" /></span>
              <span class="q-score">{{ scoreOf(i) }} 分</span>
            </div>
            <div class="q-stem">{{ q.stem }}</div>
            <div v-if="q.options" class="q-options">
              <div v-for="o in parseOptions(q.options)" :key="o.key"><b>{{ o.key }}.</b> {{ o.value }}</div>
            </div>
            <div class="q-line"><b>参考答案：</b><span class="ans">{{ q.answer || '—' }}</span></div>
            <div v-if="q.analysis" class="q-line"><b>试题解析：</b>{{ q.analysis }}</div>
          </div>
        </div>
        <div v-if="previewed && result.coverage" class="right-foot">
          <el-tag type="success">
            知识点覆盖率 {{ result.coverage.covered || 0 }}/{{ result.coverage.total || 0 }}（{{ result.coverage.rate || 0 }}%）
          </el-tag>
          <span class="tip-text ml8">抽题时优先选未覆盖的知识点</span>
        </div>
      </div>
    </div>

    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button :loading="loading" @click="doPreview">重新组卷</el-button>
      <el-button type="primary" :loading="saving" :disabled="!previewed || result.questions.length === 0"
        @click="doSave">
        保存试卷（{{ result.questions.length }} 题）
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup name="ComposeDialog">
import { listCourse } from "@/api/exam/course"
import { listChapter } from "@/api/exam/chapter"
import { composePreview, composeSave, getAvailableCount } from "@/api/exam/paper"

const emit = defineEmits(['close', 'success'])
const { proxy } = getCurrentInstance()
const { exam_question_type, exam_difficulty } = useDict('exam_question_type', 'exam_difficulty')

const visible = ref(true)
const loading = ref(false)
const saving = ref(false)
const courses = ref([])
const chapters = ref([])
const previewed = ref(false)
const result = ref({ questions: [], perScore: 0, coverage: {} })
const available = ref({ t1: 0, t2: 0, t3: 0, t4: 0, d1: 0, d2: 0, d3: 0, total: 0 })
const countLoaded = ref(false)

const form = reactive({
  courseId: null, chapterIds: [], title: '', totalScore: 100,
  t1: 6, t2: 1, t3: 1, t4: 2,
  d1: 3, d2: 6, d3: 1,
  coverage: 60
})

listCourse({ pageNum: 1, pageSize: 50 }).then(res => {
  courses.value = res.rows || []
  if (courses.value.length === 1) form.courseId = courses.value[0].id
  if (!form.title) form.title = '数据库原理与应用 期末测验（组卷演示）'
})

// 换课程就重新加载该课程的章节，已选的章节清空，预览结果作废
watch(() => form.courseId, (id) => {
  form.chapterIds = []
  chapters.value = []
  previewed.value = false
  result.value = { questions: [], perScore: 0, coverage: {} }
  if (id) {
    listChapter({ courseId: id, pageNum: 1, pageSize: 200 }).then(res => {
      chapters.value = res.rows || []
    })
  }
})

// 换课程和换章节都会走到这里，只数一次
watch(() => form.chapterIds, () => {
  previewed.value = false
  loadAvailable()
})

/** 组卷参数：预览和保存共用 */
function buildParams() {
  const typeRatio = { '1': form.t1, '2': form.t2, '3': form.t3, '4': form.t4 }
  const difficultyRatio = { '1': form.d1, '2': form.d2, '3': form.d3 }
  const chapterNames = chapters.value
    .filter(c => form.chapterIds.includes(c.id))
    .map(c => c.name)
  return {
    courseId: form.courseId, title: form.title, totalScore: form.totalScore,
    coverage: form.coverage / 100, typeRatio, difficultyRatio,
    chapterIds: form.chapterIds, chapterNames
  }
}

// 数一数当前课程/章节下能抽多少题，只算已通过审核的
function loadAvailable() {
  if (!form.courseId) {
    available.value = { t1: 0, t2: 0, t3: 0, t4: 0, d1: 0, d2: 0, d3: 0, total: 0 }
    countLoaded.value = false
    return
  }
  getAvailableCount({ courseId: form.courseId, chapterIds: form.chapterIds }).then(res => {
    available.value = res.data || {}
    countLoaded.value = true
    // 已经填好的数字不能超过题库里有的
    const keys = ['t1', 't2', 't3', 't4', 'd1', 'd2', 'd3']
    keys.forEach(k => {
      const max = Number(available.value[k] || 0)
      if (form[k] > max) form[k] = max
    })
  })
}

// 数字框上限：没数出来之前按 50，数出来之后按实际题数
function maxOf(key) {
  return countLoaded.value ? Number(available.value[key] || 0) : 50
}

function checkForm() {
  if (!form.courseId || !form.title) {
    proxy.$modal.msgWarning('请选择课程并填写试卷名称')
    return false
  }
  const total = form.t1 + form.t2 + form.t3 + form.t4
  if (total === 0) {
    proxy.$modal.msgWarning('题型配比至少要有一道题')
    return false
  }
  const keys = ['t1', 't2', 't3', 't4', 'd1', 'd2', 'd3']
  for (const k of keys) {
    if (form[k] > maxOf(k)) {
      proxy.$modal.msgWarning('题数不能超过题库里可用的题，请调整配比或先补题')
      return false
    }
  }
  return true
}

/** 生成预览：只抽题，不写库 */
function doPreview() {
  if (!checkForm()) return
  loading.value = true
  composePreview(buildParams()).then(res => {
    result.value = res.data || { questions: [], perScore: 0, coverage: {} }
    previewed.value = true
    if (!result.value.questions || result.value.questions.length === 0) {
      proxy.$modal.msgWarning('没有抽到题目，请检查题型/难度配比或先补充题库')
    }
  }).finally(() => { loading.value = false })
}

/** 保存：按预览出来的题目写库 */
function doSave() {
  if (!previewed.value || result.value.questions.length === 0) return
  const params = buildParams()
  params.questionIds = result.value.questions.map(q => q.id)
  saving.value = true
  composeSave(params).then(res => {
    proxy.$modal.msgSuccess(res.msg + '：共 ' + (res.data.questionCount || 0) + ' 题')
    emit('success')
    visible.value = false
  }).finally(() => { saving.value = false })
}

/** 每题分值：总分平均分，余数补在最后一题上 */
function scoreOf(i) {
  const n = result.value.questions.length
  const per = result.value.perScore || 0
  if (i === n - 1) return form.totalScore - per * (n - 1)
  return per
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

.cz-wrap { display: flex; gap: 16px; height: 66vh; min-height: 440px; }

.cz-left { width: 380px; flex: none; overflow-y: auto; padding-right: 4px; }
.gen-btn { width: 100%; margin-top: 4px; }
.left-tip { margin-top: 10px; font-size: 12px; line-height: 1.7; color: #909399; }
.avail-row { display: flex; align-items: center; gap: 6px; }
.avail-text { font-size: 12px; color: #909399; white-space: nowrap; }
.avail-total { margin-top: 8px; font-size: 12px; color: #606266; }
.tip-text { font-size: 12px; color: #909399; }
.ml6 { margin-left: 6px; }
.ml8 { margin-left: 8px; }
.mb8 { margin-bottom: 8px; }

.cz-right { flex: 1; min-width: 0; display: flex; flex-direction: column; }
.right-head {
  display: flex; align-items: center; justify-content: space-between;
  font-size: 14px; font-weight: 600; color: #303133; padding: 0 2px 8px;
}
.right-head .cnt { font-weight: normal; font-size: 12px; color: #909399; }
.right-body {
  flex: 1; overflow-y: auto; padding: 12px;
  border: 1px solid #ebeef5; border-radius: 4px; background: #fafafa;
}
.right-foot { padding-top: 10px; }

.q-card {
  background: #fff; border: 1px solid #ebeef5; border-radius: 4px;
  padding: 12px 14px; margin-bottom: 10px;
}
.q-card:last-child { margin-bottom: 0; }
.q-top { display: flex; align-items: center; margin-bottom: 8px; }
.q-no {
  display: inline-block; width: 20px; height: 20px; line-height: 20px; text-align: center;
  background: #409eff; color: #fff; border-radius: 50%; font-size: 12px; margin-right: 8px;
}
.q-score { margin-left: auto; font-size: 12px; color: #909399; }
.q-stem { font-size: 14px; line-height: 1.8; color: #303133; white-space: pre-wrap; word-break: break-word; }
.q-options { margin-top: 8px; font-size: 13px; line-height: 1.9; color: #606266; }
.q-line {
  margin-top: 8px; font-size: 13px; line-height: 1.8; color: #606266;
  white-space: pre-wrap; word-break: break-word;
}
.q-line .ans { color: #67c23a; font-weight: 600; }
</style>
