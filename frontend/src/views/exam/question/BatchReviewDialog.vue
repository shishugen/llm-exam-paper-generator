<template>
  <el-dialog v-model="visible" title="统一审核" width="520px" append-to-body @close="emit('close')">
    <el-alert type="info" :closable="false" show-icon class="mb8"
      :title="`已选中 ${props.ids.length} 道题，将统一执行以下操作`" />
    <el-form :model="form" label-width="90px">
      <el-form-item label="审核结果">
        <el-radio-group v-model="form.action">
          <el-radio value="2">通过</el-radio>
          <el-radio value="3">驳回</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item v-if="form.action === '3'" label="驳回原因" required>
        <el-input v-model="form.reason" type="textarea" :rows="3"
          placeholder="写清楚原因，下次 AI 出题时会自动拼进提示词开头" />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" :loading="loading" @click="submit">提交审核</el-button>
    </template>
  </el-dialog>
</template>

<script setup name="BatchReviewDialog">
import { reviewBatchQuestion } from "@/api/exam/question"

const props = defineProps({ ids: { type: Array, default: () => [] } })
const emit = defineEmits(['close', 'success'])
const { proxy } = getCurrentInstance()

const visible = ref(true)
const loading = ref(false)
const form = reactive({ action: '2', reason: '' })

function submit() {
  if (props.ids.length === 0) {
    proxy.$modal.msgWarning('没有可审核的题目')
    return
  }
  if (form.action === '3' && !form.reason) {
    proxy.$modal.msgWarning('驳回时必须填写原因')
    return
  }
  loading.value = true
  reviewBatchQuestion({ ids: props.ids, action: form.action, reason: form.reason })
    .then(res => {
      proxy.$modal.msgSuccess(res.msg || '审核完成')
      emit('success')
      visible.value = false
    })
    .finally(() => { loading.value = false })
}
</script>
