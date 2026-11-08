import request from '@/utils/request'

// 查询题库列表
export function listQuestion(query) {
  return request({
    url: '/exam/question/list',
    method: 'get',
    params: query
  })
}

// 查询题库详细
export function getQuestion(id) {
  return request({
    url: '/exam/question/' + id,
    method: 'get'
  })
}

// 新增题库
export function addQuestion(data) {
  return request({
    url: '/exam/question',
    method: 'post',
    data: data
  })
}

// 修改题库
export function updateQuestion(data) {
  return request({
    url: '/exam/question',
    method: 'put',
    data: data
  })
}

// 删除题库
export function delQuestion(id) {
  return request({
    url: '/exam/question/' + id,
    method: 'delete'
  })
}

// AI 出题预览（不入库，返回预览列表）
// 调大模型比较慢，单独给 2 分钟超时，不走全局的 10 秒
export function previewQuestions(data) {
  return request({
    url: '/exam/question/preview',
    method: 'post',
    data,
    timeout: 120000
  })
}

// AI 出题保存（将预览结果入库，status=0 待审）
export function saveGenerated(data) {
  return request({
    url: '/exam/question/saveGenerated',
    method: 'post',
    data
  })
}

// 题目审核：通过或驳回，驳回原因会反馈给下次生成
export function reviewQuestion(data) {
  return request({
    url: '/exam/question/review',
    method: 'post',
    data: data
  })
}

// 批量审核：统一通过或驳回一组题目
export function reviewBatchQuestion(data) {
  return request({
    url: '/exam/question/reviewBatch',
    method: 'post',
    data: data
  })
}
