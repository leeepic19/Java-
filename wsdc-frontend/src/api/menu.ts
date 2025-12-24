import request from '@/utils/request'

export const menuApi = {
  getList() {
    return request.get('/menu/list')
  },
  
  getRecommended() {
    return request.get('/menu/recommended')
  },
  
  getByCategory(category: string) {
    return request.get(`/menu/category/${category}`)
  },
  
  search(keyword: string) {
    return request.get('/menu/search', { params: { keyword } })
  },
  
  getById(menuId: number) {
    return request.get(`/menu/${menuId}`)
  }
}
