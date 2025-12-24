<template>
  <div class="home">
    <el-carousel height="300px" class="banner">
      <el-carousel-item v-for="i in 3" :key="i">
        <div class="banner-item" :style="{ background: `linear-gradient(135deg, ${colors[i-1]})` }">
          <h2>欢迎来到外卖点餐系统</h2>
          <p>美食美刻，尽在掌握</p>
        </div>
      </el-carousel-item>
    </el-carousel>
    
    <div class="section">
      <div class="section-header">
        <h2>🔥 推荐菜品</h2>
      </div>
      <el-row :gutter="20" v-loading="loading">
        <el-col :span="6" v-for="menu in recommendedMenus" :key="menu.menuId">
          <el-card :body-style="{ padding: '0px' }" class="menu-card" shadow="hover">
            <img :src="menu.menuImage || '/placeholder.jpg'" class="image" />
            <div class="card-content">
              <h3>{{ menu.menuName }}</h3>
              <p class="desc">{{ menu.menuContent }}</p>
              <div class="bottom">
                <span class="price">¥{{ menu.menuPrice }}</span>
                <el-button type="primary" size="small" @click="addToCart(menu)">
                  <el-icon><Plus /></el-icon>
                </el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
    
    <div class="features">
      <el-row :gutter="40">
        <el-col :span="8">
          <div class="feature-item">
            <el-icon :size="60" color="#409eff"><Timer /></el-icon>
            <h3>快速配送</h3>
            <p>30分钟内快速送达</p>
          </div>
        </el-col>
        <el-col :span="8">
          <div class="feature-item">
            <el-icon :size="60" color="#67c23a"><Check /></el-icon>
            <h3>品质保证</h3>
            <p>新鲜食材，健康美味</p>
          </div>
        </el-col>
        <el-col :span="8">
          <div class="feature-item">
            <el-icon :size="60" color="#e6a23c"><Service /></el-icon>
            <h3>贴心服务</h3>
            <p>24小时在线客服</p>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { menuApi } from '@/api/menu'
import { useCartStore } from '@/stores/cart'

const cartStore = useCartStore()
const loading = ref(false)
const recommendedMenus = ref<any[]>([])
const colors = ['#667eea 0%, #764ba2 100%', '#f093fb 0%, #f5576c 100%', '#4facfe 0%, #00f2fe 100%']

const fetchRecommendedMenus = async () => {
  loading.value = true
  try {
    const res = await menuApi.getRecommended()
    recommendedMenus.value = res.data
  } catch (error) {
    console.error('获取推荐菜品失败', error)
  } finally {
    loading.value = false
  }
}

const addToCart = (menu: any) => {
  cartStore.addToCart({
    menuId: menu.menuId,
    menuName: menu.menuName,
    menuPrice: menu.menuPrice,
    menuImage: menu.menuImage
  })
  ElMessage.success('已添加到购物车')
}

onMounted(() => {
  fetchRecommendedMenus()
})
</script>

<style scoped>
.home {
  padding-bottom: 40px;
}

.banner {
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 40px;
}

.banner-item {
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
}

.banner-item h2 {
  font-size: 36px;
  margin-bottom: 10px;
}

.section {
  margin-bottom: 40px;
}

.section-header {
  margin-bottom: 20px;
}

.section-header h2 {
  font-size: 24px;
}

.menu-card {
  margin-bottom: 20px;
  cursor: pointer;
  transition: transform 0.3s;
}

.menu-card:hover {
  transform: translateY(-5px);
}

.image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.card-content {
  padding: 14px;
}

.card-content h3 {
  font-size: 18px;
  margin-bottom: 8px;
}

.desc {
  color: #666;
  font-size: 14px;
  margin-bottom: 10px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.price {
  color: #f56c6c;
  font-size: 20px;
  font-weight: bold;
}

.features {
  background: white;
  padding: 40px;
  border-radius: 8px;
}

.feature-item {
  text-align: center;
}

.feature-item h3 {
  margin: 20px 0 10px;
  font-size: 20px;
}

.feature-item p {
  color: #666;
}
</style>
