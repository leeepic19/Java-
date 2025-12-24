<template>
  <div class="layout">
    <header class="header">
      <div class="header-content">
        <div class="logo">🍜 外卖点餐系统</div>
        <nav class="nav">
          <router-link to="/home">首页</router-link>
          <router-link to="/menu">菜单</router-link>
          <router-link to="/cart" class="cart-link">
            <el-badge :value="cartStore.totalCount" :hidden="cartStore.totalCount === 0">
              <el-icon><ShoppingCart /></el-icon>
              购物车
            </el-badge>
          </router-link>
          <router-link to="/order" v-if="userStore.token">我的订单</router-link>
          <router-link to="/profile" v-if="userStore.token">个人中心</router-link>
        </nav>
        <div class="user-info">
          <template v-if="userStore.token">
            <span>{{ userStore.userInfo?.userRealname || '用户' }}</span>
            <el-button size="small" @click="handleLogout">退出</el-button>
          </template>
          <template v-else>
            <el-button size="small" @click="$router.push('/login')">登录</el-button>
            <el-button size="small" type="primary" @click="$router.push('/register')">注册</el-button>
          </template>
        </div>
      </div>
    </header>
    
    <main class="main">
      <router-view />
    </main>
    
    <footer class="footer">
      <p>© 2025 外卖点餐系统 All Rights Reserved</p>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import { useCartStore } from '@/stores/cart'
import { authApi } from '@/api/auth'

const userStore = useUserStore()
const cartStore = useCartStore()

const handleLogout = () => {
  userStore.logout()
  ElMessage.success('退出成功')
}

onMounted(async () => {
  if (userStore.token && !userStore.userInfo) {
    try {
      const res = await authApi.getCurrentUser()
      userStore.setUserInfo(res.data)
    } catch (error) {
      console.error('获取用户信息失败', error)
    }
  }
})
</script>

<style scoped>
.layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
}

.nav {
  display: flex;
  gap: 30px;
  flex: 1;
  margin-left: 60px;
}

.nav a {
  color: #333;
  text-decoration: none;
  padding: 8px 16px;
  border-radius: 4px;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 5px;
}

.nav a:hover,
.nav a.router-link-active {
  color: #409eff;
  background: #ecf5ff;
}

.cart-link {
  position: relative;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.main {
  flex: 1;
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
  width: 100%;
}

.footer {
  background: #fff;
  text-align: center;
  padding: 20px;
  color: #666;
  border-top: 1px solid #eee;
}
</style>
