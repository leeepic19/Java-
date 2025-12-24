<template>
  <div class="profile">
    <h2>个人中心</h2>
    
    <el-card>
      <template #header>
        <span>基本信息</span>
      </template>
      
      <el-descriptions :column="2" border v-if="userStore.userInfo">
        <el-descriptions-item label="用户名">
          {{ userStore.userInfo.userName }}
        </el-descriptions-item>
        <el-descriptions-item label="真实姓名">
          {{ userStore.userInfo.userRealname }}
        </el-descriptions-item>
        <el-descriptions-item label="性别">
          {{ userStore.userInfo.userSex || '-' }}
        </el-descriptions-item>
        <el-descriptions-item label="用户类型">
          <el-tag>{{ userStore.userInfo.userFlag }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="邮箱">
          {{ userStore.userInfo.userMail || '-' }}
        </el-descriptions-item>
        <el-descriptions-item label="手机号">
          {{ userStore.userInfo.userPhone || '-' }}
        </el-descriptions-item>
        <el-descriptions-item label="注册时间" :span="2">
          {{ formatTime(userStore.userInfo.createTime) }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

const formatTime = (time: any) => {
  return new Date(time).toLocaleString('zh-CN')
}
</script>

<style scoped>
.profile {
  background: white;
  padding: 20px;
  border-radius: 8px;
}

.profile h2 {
  margin-bottom: 20px;
}
</style>
