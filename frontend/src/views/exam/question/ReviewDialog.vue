<template>
  <el-dialog v-model="visible" title="题目审核" width="700px" append-to-body @close="emit('close')">
    <el-descriptions :column="2" border class="mb8">
      <el-descriptions-item label="题目">{{ q.stem }}</el-descriptions-item>
      <el-descriptions-item label="来源">{{ q.source === '1' ? 'AI 生成' : '人工录入' }}</el-descriptions-item>
      <el-descriptions-item label="知识点">{{ q.knowledgeName || '—' }}</el-descriptions-item>
      <el-descriptions-item label="分值">{{ q.score }}</el-descriptions-item>
    </el-descriptions>
    <el-card shadow="never" class="mb8">
      <div class="q-title">题干</div>
      <div class="q-body">{{ q.stem }}</div>
      <div class="q-title">选项</div>
      <div class="q-body">{{ optionText(q.options) }}</div>
      <div class="q-title">参考答案</div>
      <div class="q-body">{{ q.answer }}</div>
      <div class="q-title">解析</div>
      <div class="q-body">{{ q.analysis }}</div>
    </el-card>
    <el-form :model="form" label-width="90px">
      <el-form-item label="审核结果">
        <el-radio-group v-model="form.action">
          <el-radio value="2">通过</el-radio>
          <el-radio value="3">驳回</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item v-if="form.action === '3'" label="驳回原因" required>
        <el-input v-model="form.reason" type="textarea" :rows="2"
          placeholder="写清楚原因，下次 AI 出题时会自动拼进提示词开头" />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" :loading="loading" @click="submit">提交审核</el-button>
    </template>
  </el-dialog>
</template>

<script setup name="ReviewDialog">
import { getQuestion } from "@/api/exam/question"
import { reviewQuestion } from "@/api/exam/question"
import useUserStore from '@/store/modules/user'

const props = defineProps({ questionId: [Number, String] })
const emit = defineEmits(['close', 'success'])
const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const visible = ref(true)
const loading = ref(false)
const q = ref({})
const form = reactive({ action: '2', reason: '' })

getQuestion(props.questionId).then(res => { q.value = res.data || {} })

function optionText(value) {
  if (!value) return '（本题无选项）'
  try {
    return JSON.parse(value).map(o => `${o.key}. ${o.value}`).join('    ')
  } catch (e) {
    return value
  }
}

function submit() {
  if (form.action === '3' && !form.reason) {
    proxy.$modal.msgWarning('驳回时必须填写原因')
    return
  }
  loading.value = true
  reviewQuestion({ questionId: props.questionId, action: form.action, reason: form.reason,
                  reviewerId: userStore.id })
    .then(res => {
      proxy.$modal.msgSuccess(res.msg || '审核完成')
      emit('success')
      visible.value = false
    })
    .finally(() => { loading.value = false })
}
</script>

<style scoped>
.q-title { font-weight: 600; margin: 8px 0 4px; color: #303133; }
.q-body { white-space: pre-wrap; line-height: 1.7; color: #606266; }
</style>
