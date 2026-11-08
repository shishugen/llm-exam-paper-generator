import request from '@/utils/request'

// 查询大模型调用日志列表
export function listAiCallLog(query) {
  return request({
    url: '/exam/aiCallLog/list',
    method: 'get',
    params: query
  })
}

// 查询大模型调用日志详细
export function getAiCallLog(id) {
  return request({
    url: '/exam/aiCallLog/' + id,
    method: 'get'
  })
}

// 新增大模型调用日志
export function addAiCallLog(data) {
  return request({
    url: '/exam/aiCallLog',
    method: 'post',
    data: data
  })
}

// 修改大模型调用日志
export function updateAiCallLog(data) {
  return request({
    url: '/exam/aiCallLog',
    method: 'put',
    data: data
  })
}

// 删除大模型调用日志
export function delAiCallLog(id) {
  return request({
    url: '/exam/aiCallLog/' + id,
    method: 'delete'
  })
}

// 调用统计：次数 / Token / 平均耗时 / 费用 / 成功率
export function getCallStats() {
  return request({
    url: '/exam/aiCallLog/stats',
    method: 'get'
  })
}
