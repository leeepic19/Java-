import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export interface CartItem {
  menuId: number
  menuName: string
  menuPrice: number
  menuImage?: string
  quantity: number
}

export const useCartStore = defineStore('cart', () => {
  const items = ref<CartItem[]>([])

  const totalAmount = computed(() => {
    return items.value.reduce((sum, item) => sum + item.menuPrice * item.quantity, 0)
  })

  const totalCount = computed(() => {
    return items.value.reduce((sum, item) => sum + item.quantity, 0)
  })

  const addToCart = (item: Omit<CartItem, 'quantity'>) => {
    const existItem = items.value.find(i => i.menuId === item.menuId)
    if (existItem) {
      existItem.quantity++
    } else {
      items.value.push({ ...item, quantity: 1 })
    }
  }

  const removeFromCart = (menuId: number) => {
    const index = items.value.findIndex(i => i.menuId === menuId)
    if (index > -1) {
      items.value.splice(index, 1)
    }
  }

  const updateQuantity = (menuId: number, quantity: number) => {
    const item = items.value.find(i => i.menuId === menuId)
    if (item) {
      item.quantity = quantity
    }
  }

  const clearCart = () => {
    items.value = []
  }

  return {
    items,
    totalAmount,
    totalCount,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart
  }
})
