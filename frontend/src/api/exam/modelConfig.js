import request from '@/utils/request'

// 查询模型配置列表
export function listModelConfig(query) {
  return request({
    url: '/exam/modelConfig/list',
    method: 'get',
    params: query
  })
}

// 查询模型配置详细
export function getModelConfig(id) {
  return request({
    url: '/exam/modelConfig/' + id,
    method: 'get'
  })
}

// 新增模型配置
export function addModelConfig(data) {
  return request({
    url: '/exam/modelConfig',
    method: 'post',
    data: data
  })
}

// 修改模型配置
export function updateModelConfig(data) {
  return request({
    url: '/exam/modelConfig',
    method: 'put',
    data: data
  })
}

// 删除模型配置
export function delModelConfig(id) {
  return request({
    url: '/exam/modelConfig/' + id,
    method: 'delete'
  })
}
