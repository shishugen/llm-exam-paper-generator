import request from '@/utils/request'

// 查询试卷明细列表
export function listPaperQuestion(query) {
  return request({
    url: '/exam/paperQuestion/list',
    method: 'get',
    params: query
  })
}

// 查询试卷明细详细
export function getPaperQuestion(id) {
  return request({
    url: '/exam/paperQuestion/' + id,
    method: 'get'
  })
}

// 新增试卷明细
export function addPaperQuestion(data) {
  return request({
    url: '/exam/paperQuestion',
    method: 'post',
    data: data
  })
}

// 修改试卷明细
export function updatePaperQuestion(data) {
  return request({
    url: '/exam/paperQuestion',
    method: 'put',
    data: data
  })
}

// 删除试卷明细
export function delPaperQuestion(id) {
  return request({
    url: '/exam/paperQuestion/' + id,
    method: 'delete'
  })
}
