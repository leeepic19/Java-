<template>
  <div class="menu">
    <div class="search-bar">
      <el-input 
        v-model="searchKeyword" 
        placeholder="搜索菜品..." 
        clearable
        @keyup.enter="handleSearch"
      >
        <template #append>
          <el-button @click="handleSearch" :icon="Search">搜索</el-button>
        </template>
      </el-input>
    </div>
    
    <el-tabs v-model="activeCategory" @tab-change="handleCategoryChange">
      <el-tab-pane label="全部" name="all"></el-tab-pane>
      <el-tab-pane label="热菜" name="热菜"></el-tab-pane>
      <el-tab-pane label="凉菜" name="凉菜"></el-tab-pane>
      <el-tab-pane label="主食" name="主食"></el-tab-pane>
      <el-tab-pane label="汤品" name="汤品"></el-tab-pane>
      <el-tab-pane label="饮料" name="饮料"></el-tab-pane>
    </el-tabs>
    
    <el-row :gutter="20" v-loading="loading">
      <el-col :span="6" v-for="menu in menuList" :key="menu.menuId">
        <el-card :body-style="{ padding: '0px' }" class="menu-card" shadow="hover">
          <img :src="menu.menuImage || '/placeholder.jpg'" class="image" />
          <div class="card-content">
            <div class="menu-header">
              <h3>{{ menu.menuName }}</h3>
              <el-tag v-if="menu.isRecommended" type="danger" size="small">推荐</el-tag>
            </div>
            <p class="desc">{{ menu.menuContent }}</p>
            <div class="info">
              <span class="stock">库存: {{ menu.stock }}</span>
              <span class="sales">已售: {{ menu.sales }}</span>
            </div>
            <div class="bottom">
              <span class="price">¥{{ menu.menuPrice }}</span>
              <el-button 
                type="primary" 
                size="small" 
                @click="addToCart(menu)"
                :disabled="menu.stock === 0"
              >
                <el-icon><Plus /></el-icon>
                {{ menu.stock === 0 ? '已售罄' : '加入购物车' }}
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-empty v-if="!loading && menuList.length === 0" description="暂无菜品" />
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import { menuApi } from '@/api/menu'
import { useCartStore } from '@/stores/cart'

const cartStore = useCartStore()
const loading = ref(false)
const menuList = ref<any[]>([])
const activeCategory = ref('all')
const searchKeyword = ref('')

const fetchMenuList = async () => {
  loading.value = true
  try {
    const res = await menuApi.getList()
    menuList.value = res.data
  } catch (error) {
    console.error('获取菜品列表失败', error)
  } finally {
    loading.value = false
  }
}

const handleCategoryChange = async (category: string) => {
  if (category === 'all') {
    await fetchMenuList()
  } else {
    loading.value = true
    try {
      const res = await menuApi.getByCategory(category)
      menuList.value = res.data
    } catch (error) {
      console.error('获取分类菜品失败', error)
    } finally {
      loading.value = false
    }
  }
}

const handleSearch = async () => {
  if (!searchKeyword.value.trim()) {
    await fetchMenuList()
    return
  }
  
  loading.value = true
  try {
    const res = await menuApi.search(searchKeyword.value)
    menuList.value = res.data
  } catch (error) {
    console.error('搜索菜品失败', error)
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
  fetchMenuList()
})
</script>

<style scoped>
.menu {
  padding-bottom: 40px;
}

.search-bar {
  margin-bottom: 20px;
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

.menu-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.menu-header h3 {
  font-size: 18px;
  margin: 0;
}

.desc {
  color: #666;
  font-size: 14px;
  margin-bottom: 10px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.info {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 12px;
  color: #999;
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
</style>
