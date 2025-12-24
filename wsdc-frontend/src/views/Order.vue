<template>
  <div class="order">
    <h2>我的订单</h2>
    
    <el-table :data="orderList" style="width: 100%" v-loading="loading">
      <el-table-column prop="orderNo" label="订单号" width="180" />
      
      <el-table-column label="订单金额" width="120">
        <template #default="{ row }">
          <span class="price">¥{{ row.totalAmount }}</span>
        </template>
      </el-table-column>
      
      <el-table-column label="订单状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">{{ row.status }}</el-tag>
        </template>
      </el-table-column>
      
      <el-table-column prop="deliveryAddress" label="配送地址" />
      
      <el-table-column label="下单时间" width="180">
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button size="small" @click="viewDetail(row)">查看详情</el-button>
          <el-button 
            v-if="row.status === '待支付'" 
            type="primary" 
            size="small" 
            @click="handlePay(row)"
          >
            去支付
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <el-empty v-if="!loading && orderList.length === 0" description="暂无订单" />
    
    <el-dialog v-model="showDetailDialog" title="订单详情" width="600px">
      <div v-if="currentOrder">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="订单号">{{ currentOrder.orderNo }}</el-descriptions-item>
          <el-descriptions-item label="订单状态">
            <el-tag :type="getStatusType(currentOrder.status)">{{ currentOrder.status }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="订单金额">
            <span class="price">¥{{ currentOrder.totalAmount }}</span>
          </el-descriptions-item>
          <el-descriptions-item label="支付方式">
            {{ currentOrder.paymentMethod || '-' }}
          </el-descriptions-item>
          <el-descriptions-item label="配送地址" :span="2">
            {{ currentOrder.deliveryAddress }}
          </el-descriptions-item>
          <el-descriptions-item label="联系电话">{{ currentOrder.phone }}</el-descriptions-item>
          <el-descriptions-item label="备注">{{ currentOrder.remark || '-' }}</el-descriptions-item>
          <el-descriptions-item label="下单时间" :span="2">
            {{ formatTime(currentOrder.createTime) }}
          </el-descriptions-item>
        </el-descriptions>
        
        <h3 style="margin: 20px 0 10px;">订单明细</h3>
        <el-table :data="currentOrder.items" border>
          <el-table-column label="菜品">
            <template #default="{ row }">
              <div class="menu-info">
                <img :src="row.menuImage || '/placeholder.jpg'" class="menu-image" />
                <span>{{ row.menuName }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="price" label="单价" width="100">
            <template #default="{ row }">¥{{ row.price }}</template>
          </el-table-column>
          <el-table-column prop="quantity" label="数量" width="80" />
          <el-table-column prop="subtotal" label="小计" width="100">
            <template #default="{ row }">¥{{ row.subtotal }}</template>
          </el-table-column>
        </el-table>
      </div>
    </el-dialog>
    
    <el-dialog v-model="showPayDialog" title="支付订单" width="400px">
      <el-radio-group v-model="paymentMethod">
        <el-radio label="微信支付">微信支付</el-radio>
        <el-radio label="支付宝">支付宝</el-radio>
        <el-radio label="现金支付">现金支付</el-radio>
      </el-radio-group>
      
      <template #footer>
        <el-button @click="showPayDialog = false">取消</el-button>
        <el-button type="primary" @click="confirmPay" :loading="paying">
          确认支付
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { orderApi } from '@/api/order'

const loading = ref(false)
const orderList = ref<any[]>([])
const showDetailDialog = ref(false)
const showPayDialog = ref(false)
const currentOrder = ref<any>(null)
const paymentMethod = ref('微信支付')
const paying = ref(false)

const fetchOrderList = async () => {
  loading.value = true
  try {
    const res = await orderApi.getMyOrders()
    orderList.value = res.data
  } catch (error) {
    console.error('获取订单列表失败', error)
  } finally {
    loading.value = false
  }
}

const viewDetail = async (order: any) => {
  try {
    const res = await orderApi.getById(order.orderId)
    currentOrder.value = res.data
    showDetailDialog.value = true
  } catch (error) {
    ElMessage.error('获取订单详情失败')
  }
}

const handlePay = (order: any) => {
  currentOrder.value = order
  showPayDialog.value = true
}

const confirmPay = async () => {
  if (!currentOrder.value) return
  
  paying.value = true
  try {
    await orderApi.pay(currentOrder.value.orderId, paymentMethod.value)
    ElMessage.success('支付成功')
    showPayDialog.value = false
    await fetchOrderList()
  } catch (error: any) {
    ElMessage.error(error.message || '支付失败')
  } finally {
    paying.value = false
  }
}

const getStatusType = (status: string) => {
  const statusMap: Record<string, any> = {
    '待支付': 'warning',
    '已支付': 'success',
    '配送中': 'primary',
    '已完成': 'info',
    '已取消': 'danger'
  }
  return statusMap[status] || 'info'
}

const formatTime = (time: string) => {
  return new Date(time).toLocaleString('zh-CN')
}

onMounted(() => {
  fetchOrderList()
})
</script>

<style scoped>
.order {
  background: white;
  padding: 20px;
  border-radius: 8px;
}

.order h2 {
  margin-bottom: 20px;
}

.price {
  color: #f56c6c;
  font-weight: bold;
}

.menu-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.menu-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  border-radius: 4px;
}
</style>
