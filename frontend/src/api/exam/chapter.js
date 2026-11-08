import request from '@/utils/request'

// 查询章节列表
export function listChapter(query) {
  return request({
    url: '/exam/chapter/list',
    method: 'get',
    params: query
  })
}

// 查询章节详细
export function getChapter(id) {
  return request({
    url: '/exam/chapter/' + id,
    method: 'get'
  })
}

// 新增章节
export function addChapter(data) {
  return request({
    url: '/exam/chapter',
    method: 'post',
    data: data
  })
}

// 修改章节
export function updateChapter(data) {
  return request({
    url: '/exam/chapter',
    method: 'put',
    data: data
  })
}

// 删除章节
export function delChapter(id) {
  return request({
    url: '/exam/chapter/' + id,
    method: 'delete'
  })
}
