import request from '@/utils/request'

export interface LoginData {
  userName: string
  password: string
}

export interface RegisterData {
  userName: string
  password: string
  userRealname: string
  userSex?: string
  userMail?: string
  userPhone?: string
}

export const authApi = {
  login(data: LoginData) {
    return request.post('/auth/login', data)
  },
  
  register(data: RegisterData) {
    return request.post('/auth/register', data)
  },
  
  getCurrentUser() {
    return request.get('/auth/current')
  }
}
