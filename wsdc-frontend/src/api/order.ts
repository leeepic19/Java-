import request from '@/utils/request'

export interface OrderItemData {
  menuId: number
  quantity: number
}

export interface OrderData {
  items: OrderItemData[]
  deliveryAddress: string
  phone: string
  remark?: string
}

export const orderApi = {
  create(data: OrderData) {
    return request.post('/order/create', data)
  },
  
  pay(orderId: number, paymentMethod: string) {
    return request.post(`/order/${orderId}/pay`, null, {
      params: { paymentMethod }
    })
  },
  
  getMyOrders() {
    return request.get('/order/my')
  },
  
  getById(orderId: number) {
    return request.get(`/order/${orderId}`)
  }
}
