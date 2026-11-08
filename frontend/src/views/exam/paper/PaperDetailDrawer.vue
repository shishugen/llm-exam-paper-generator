<template>
  <el-drawer v-model="visible" :title="paper.title || '试卷详情'" size="72%" append-to-body @close="emit('close')">
    <div class="head-bar">
      <el-tag type="primary">总分 {{ paper.totalScore }} 分</el-tag>
      <el-tag type="info" class="ml8">共 {{ rows.length }} 道题</el-tag>
      <el-tag type="success" class="ml8">
        知识点覆盖率 {{ coverage.covered || 0 }}/{{ coverage.total || 0 }}（{{ coverage.rate || 0 }}%）
      </el-tag>
      <div class="head-ops">
        <el-button type="primary" plain icon="Download" @click="handleExport">导出 Word</el-button>
        <el-button icon="Refresh" @click="load">刷新</el-button>
      </div>
    </div>

    <el-alert v-if="coverage.total && coverage.rate < 60" type="warning" :closable="false" show-icon
      class="mb8" title="知识点覆盖率偏低"
      description="建议补充该课程的题目后再重新组卷；覆盖率只统计展示，不影响本卷使用。" />

    <div v-loading="loading" class="q-list">
      <el-empty v-if="!loading && rows.length === 0" description="这份试卷还没有题目" :image-size="80" />

      <div v-for="q in rows" :key="q.detailId" class="q-card">
        <div class="q-top">
          <span class="q-no">{{ q.sortNo }}</span>
          <dict-tag :options="exam_question_type" :value="q.type" />
          <span class="ml8"><dict-tag :options="exam_difficulty" :value="q.difficulty" /></span>
          <span class="q-score">{{ q.score }} 分</span>
          <el-tag v-if="q.locked === '1'" type="warning" size="small" class="ml8">已锁定</el-tag>
          <div class="q-ops">
            <el-button link type="primary" :disabled="q.locked === '1'" @click="handleReplace(q)">替换</el-button>
            <el-button link type="primary" @click="handleLock(q)">{{ q.locked === '1' ? '解锁' : '锁定' }}</el-button>
          </div>
        </div>

        <div class="q-stem">{{ q.stem }}</div>

        <div v-if="q.options" class="q-options">
          <div v-for="o in parseOptions(q.options)" :key="o.key">
            <b>{{ o.key }}.</b> {{ o.value }}
          </div>
        </div>

        <div class="q-line"><b>参考答案：</b><span class="ans">{{ q.answer || '—' }}</span></div>
        <div v-if="q.analysis" class="q-line"><b>试题解析：</b>{{ q.analysis }}</div>
      </div>
    </div>
  </el-drawer>
</template>

<script setup name="PaperDetailDrawer">
import { getPaperDetail, replaceQuestion, exportPaper } from "@/api/exam/paper"
import { updatePaperQuestion } from "@/api/exam/paperQuestion"

const props = defineProps({ paperId: [Number, String] })
const emit = defineEmits(['close'])
const { proxy } = getCurrentInstance()
const { exam_question_type, exam_difficulty } = useDict('exam_question_type', 'exam_difficulty')

const visible = ref(true)
const loading = ref(false)
const paper = ref({})
const rows = ref([])
const coverage = ref({})

function load() {
  loading.value = true
  getPaperDetail(props.paperId).then(res => {
    const d = res.data || {}
    paper.value = d.paper || {}
    rows.value = d.rows || []
    coverage.value = d.coverage || {}
  }).finally(() => { loading.value = false })
}

function handleReplace(row) {
  replaceQuestion({ paperId: props.paperId, detailId: row.detailId }).then(res => {
    proxy.$modal.msgSuccess(res.msg || '替换完成')
    load()
  })
}

function handleLock(row) {
  const locked = row.locked === '1' ? '0' : '1'
  updatePaperQuestion({ id: row.detailId, locked }).then(() => {
    proxy.$modal.msgSuccess(locked === '1' ? '已锁定，替换时会跳过这道题' : '已解锁')
    load()
  })
}

function handleExport() {
  exportPaper(props.paperId, (paper.value.title || '试卷') + '.docx')
}

// options 在库里是 JSON 字符串，转成数组渲染
function parseOptions(jsonStr) {
  try {
    return JSON.parse(jsonStr) || []
  } catch (e) {
    return []
  }
}

load()
</script>

<style scoped>
.head-bar {
  display: flex; align-items: center; flex-wrap: wrap;
  gap: 6px; padding-bottom: 12px; margin-bottom: 12px;
  border-bottom: 1px solid #ebeef5;
}
.head-ops { margin-left: auto; }
.mb8 { margin-bottom: 8px; }
.ml8 { margin-left: 8px; }

.q-list { padding-bottom: 12px; }

.q-card {
  background: #fff; border: 1px solid #ebeef5; border-radius: 4px;
  padding: 14px 16px; margin-bottom: 12px;
}
.q-top { display: flex; align-items: center; margin-bottom: 10px; }
.q-no {
  display: inline-block; width: 22px; height: 22px; line-height: 22px; text-align: center;
  background: #409eff; color: #fff; border-radius: 50%; font-size: 12px; margin-right: 10px;
}
.q-score { margin-left: 10px; font-size: 12px; color: #909399; }
.q-ops { margin-left: auto; }

.q-stem { font-size: 14px; line-height: 1.9; color: #303133; white-space: pre-wrap; word-break: break-word; }
.q-options { margin-top: 8px; font-size: 13px; line-height: 2; color: #606266; }
.q-line {
  margin-top: 8px; font-size: 13px; line-height: 1.9; color: #606266;
  white-space: pre-wrap; word-break: break-word;
}
.q-line .ans { color: #67c23a; font-weight: 600; }
</style>
