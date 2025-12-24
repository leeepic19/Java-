import { defineStore } from 'pinia'
import { ref } from 'vue'
import router from '@/router'

export interface UserInfo {
  userId: number
  userName: string
  userRealname: string
  userFlag: string
  userMail?: string
  userPhone?: string
  userAvatar?: string
}

export const useUserStore = defineStore('user', () => {
  const token = ref<string>(localStorage.getItem('token') || '')
  const userInfo = ref<UserInfo | null>(null)

  const setToken = (newToken: string) => {
    token.value = newToken
    localStorage.setItem('token', newToken)
  }

  const setUserInfo = (info: UserInfo) => {
    userInfo.value = info
  }

  const logout = () => {
    token.value = ''
    userInfo.value = null
    localStorage.removeItem('token')
    router.push('/login')
  }

  return {
    token,
    userInfo,
    setToken,
    setUserInfo,
    logout
  }
})
