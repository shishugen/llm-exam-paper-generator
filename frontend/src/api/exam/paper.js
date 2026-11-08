import request, { download } from '@/utils/request'

// 查询试卷列表
export function listPaper(query) {
  return request({
    url: '/exam/paper/list',
    method: 'get',
    params: query
  })
}

// 查询试卷详细
export function getPaper(id) {
  return request({
    url: '/exam/paper/' + id,
    method: 'get'
  })
}

// 新增试卷
export function addPaper(data) {
  return request({
    url: '/exam/paper',
    method: 'post',
    data: data
  })
}

// 修改试卷
export function updatePaper(data) {
  return request({
    url: '/exam/paper',
    method: 'put',
    data: data
  })
}

// 删除试卷
export function delPaper(id) {
  return request({
    url: '/exam/paper/' + id,
    method: 'delete'
  })
}

// 一键组卷-预览：只抽题不入库，先看题目再决定要不要保存
export function composePreview(data) {
  return request({
    url: '/exam/paper/composePreview',
    method: 'post',
    data: data
  })
}

// 一键组卷-保存：浏览确认后，按预览出来的题号写库
export function composeSave(data) {
  return request({
    url: '/exam/paper/composeSave',
    method: 'post',
    data: data
  })
}

// 单题替换：锁定题跳过，按同题型同难度重抽
export function replaceQuestion(data) {
  return request({
    url: '/exam/paper/replace',
    method: 'post',
    data: data
  })
}

// 试卷详情：整卷题目明细 + 知识点覆盖率
export function getPaperDetail(paperId) {
  return request({
    url: '/exam/paper/detail',
    method: 'get',
    params: { paperId: paperId }
  })
}

// 导出 Word：试题卷与答案卷分离
export function exportPaper(paperId, filename) {
  return download('/exam/paper/exportWord', { paperId }, filename)
}
