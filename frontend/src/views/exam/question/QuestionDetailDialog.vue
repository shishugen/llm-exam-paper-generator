<template>
  <el-dialog v-model="visible" title="题目详细" width="720px" append-to-body @close="emit('close')">
    <el-descriptions :column="2" border class="mb8">
      <el-descriptions-item label="所属课程">{{ q.courseName || '—' }}</el-descriptions-item>
      <el-descriptions-item label="所属章节">{{ q.chapterName || '—' }}</el-descriptions-item>
      <el-descriptions-item label="所属知识点">{{ q.knowledgeName || '—' }}</el-descriptions-item>
      <el-descriptions-item label="分值">{{ q.score }}</el-descriptions-item>
      <el-descriptions-item label="题型">
        <dict-tag :options="exam_question_type" :value="q.type" />
      </el-descriptions-item>
      <el-descriptions-item label="难度">
        <dict-tag :options="exam_difficulty" :value="q.difficulty" />
      </el-descriptions-item>
      <el-descriptions-item label="状态">
        <dict-tag :options="exam_question_status" :value="q.status" />
      </el-descriptions-item>
      <el-descriptions-item label="来源">
        <dict-tag :options="exam_source" :value="q.source" />
      </el-descriptions-item>
    </el-descriptions>

    <el-card shadow="never" class="mb8">
      <div class="q-title">题干</div>
      <div class="q-body">{{ q.stem }}</div>

      <div class="q-title">选项</div>
      <div class="q-body">{{ optionText(q.options) }}</div>

      <div class="q-title">参考答案</div>
      <div class="q-body">{{ q.answer || '—' }}</div>

      <div class="q-title">试题解析</div>
      <div class="q-body">{{ q.analysis || '—' }}</div>

      <template v-if="q.status === '3'">
        <div class="q-title reject">驳回原因</div>
        <div class="q-body">{{ q.rejectReason || '—' }}</div>
      </template>
    </el-card>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="审核人">{{ q.reviewerName || '—' }}</el-descriptions-item>
      <el-descriptions-item label="审核时间">{{ q.reviewTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="创建时间">{{ q.createTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{ q.updateTime || '—' }}</el-descriptions-item>
    </el-descriptions>

    <template #footer>
      <el-button @click="visible = false">关 闭</el-button>
    </template>
  </el-dialog>
</template>

<script setup name="QuestionDetailDialog">
import { getQuestion } from "@/api/exam/question"

const props = defineProps({ questionId: [Number, String] })
const emit = defineEmits(['close'])

const { proxy } = getCurrentInstance()
const { exam_source, exam_difficulty, exam_question_status, exam_question_type } =
  useDict('exam_source', 'exam_difficulty', 'exam_question_status', 'exam_question_type')

const visible = ref(true)
const q = ref({})

getQuestion(props.questionId).then(res => { q.value = res.data || {} })

function optionText(value) {
  if (!value) return '（本题无选项，如判断题 / 简答题）'
  try {
    return JSON.parse(value).map(o => `${o.key}. ${o.value}`).join('\n')
  } catch (e) {
    return value
  }
}
</script>

<style scoped>
.q-title { font-weight: 600; margin: 10px 0 4px; color: #303133; }
.q-title.reject { color: #f56c6c; }
.q-body { white-space: pre-wrap; line-height: 1.7; color: #606266; }
</style>
