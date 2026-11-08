import request from '@/utils/request'

// 查询题目审核记录列表
export function listReviewLog(query) {
  return request({
    url: '/exam/reviewLog/list',
    method: 'get',
    params: query
  })
}

// 查询题目审核记录详细
export function getReviewLog(id) {
  return request({
    url: '/exam/reviewLog/' + id,
    method: 'get'
  })
}

// 新增题目审核记录
export function addReviewLog(data) {
  return request({
    url: '/exam/reviewLog',
    method: 'post',
    data: data
  })
}

// 修改题目审核记录
export function updateReviewLog(data) {
  return request({
    url: '/exam/reviewLog',
    method: 'put',
    data: data
  })
}

// 删除题目审核记录
export function delReviewLog(id) {
  return request({
    url: '/exam/reviewLog/' + id,
    method: 'delete'
  })
}
