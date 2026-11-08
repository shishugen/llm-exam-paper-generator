import request from '@/utils/request'

// 查询提示词列表
export function listPrompt(query) {
  return request({
    url: '/exam/prompt/list',
    method: 'get',
    params: query
  })
}

// 查询提示词详细
export function getPrompt(id) {
  return request({
    url: '/exam/prompt/' + id,
    method: 'get'
  })
}

// 新增提示词
export function addPrompt(data) {
  return request({
    url: '/exam/prompt',
    method: 'post',
    data: data
  })
}

// 修改提示词
export function updatePrompt(data) {
  return request({
    url: '/exam/prompt',
    method: 'put',
    data: data
  })
}

// 删除提示词
export function delPrompt(id) {
  return request({
    url: '/exam/prompt/' + id,
    method: 'delete'
  })
}
