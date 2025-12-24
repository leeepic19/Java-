<template>
  <div class="cart">
    <h2>购物车</h2>
    
    <el-table :data="cartStore.items" style="width: 100%" v-if="cartStore.items.length > 0">
      <el-table-column label="菜品">
        <template #default="{ row }">
          <div class="menu-info">
            <img :src="row.menuImage || '/placeholder.jpg'" class="menu-image" />
            <span>{{ row.menuName }}</span>
          </div>
        </template>
      </el-table-column>
      
      <el-table-column label="单价" width="120">
        <template #default="{ row }">
          <span class="price">¥{{ row.menuPrice }}</span>
        </template>
      </el-table-column>
      
      <el-table-column label="数量" width="180">
        <template #default="{ row }">
          <el-input-number 
            v-model="row.quantity" 
            :min="1" 
            :max="99"
            @change="updateQuantity(row.menuId, row.quantity)"
          />
        </template>
      </el-table-column>
      
      <el-table-column label="小计" width="120">
        <template #default="{ row }">
          <span class="price">¥{{ (row.menuPrice * row.quantity).toFixed(2) }}</span>
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="100">
        <template #default="{ row }">
          <el-button type="danger" size="small" @click="removeFromCart(row.menuId)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <el-empty v-else description="购物车是空的，快去选购吧！">
      <el-button type="primary" @click="$router.push('/menu')">去选购</el-button>
    </el-empty>
    
    <div class="cart-footer" v-if="cartStore.items.length > 0">
      <div class="total">
        <span>总计:</span>
        <span class="total-price">¥{{ cartStore.totalAmount.toFixed(2) }}</span>
      </div>
      <el-button type="primary" size="large" @click="showCheckoutDialog = true">
        去结算
      </el-button>
    </div>
    
    <el-dialog v-model="showCheckoutDialog" title="确认订单" width="500px">
      <el-form :model="orderForm" :rules="orderRules" ref="orderFormRef" label-width="100px">
        <el-form-item label="配送地址" prop="deliveryAddress">
          <el-input 
            v-model="orderForm.deliveryAddress" 
            type="textarea" 
            :rows="2"
            placeholder="请输入详细的配送地址"
          />
        </el-form-item>
        
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="orderForm.phone" placeholder="请输入联系电话" />
        </el-form-item>
        
        <el-form-item label="备注">
          <el-input 
            v-model="orderForm.remark" 
            type="textarea" 
            :rows="2"
            placeholder="如需备注请输入"
          />
        </el-form-item>
      </el-form>
      
      <template #footer>
        <el-button @click="showCheckoutDialog = false">取消</el-button>
        <el-button type="primary" @click="handleCheckout" :loading="submitting">
          提交订单
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useCartStore } from '@/stores/cart'
import { orderApi } from '@/api/order'
import type { FormInstance, FormRules } from 'element-plus'

const router = useRouter()
const cartStore = useCartStore()
const orderFormRef = ref<FormInstance>()
const showCheckoutDialog = ref(false)
const submitting = ref(false)

const orderForm = reactive({
  deliveryAddress: '',
  phone: '',
  remark: ''
})

const orderRules: FormRules = {
  deliveryAddress: [{ required: true, message: '请输入配送地址', trigger: 'blur' }],
  phone: [
    { required: true, message: '请输入联系电话', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ]
}

const updateQuantity = (menuId: number, quantity: number) => {
  cartStore.updateQuantity(menuId, quantity)
}

const removeFromCart = (menuId: number) => {
  cartStore.removeFromCart(menuId)
  ElMessage.success('已从购物车移除')
}

const handleCheckout = async () => {
  if (!orderFormRef.value) return
  
  await orderFormRef.value.validate(async (valid) => {
    if (valid) {
      submitting.value = true
      try {
        const orderData = {
          items: cartStore.items.map(item => ({
            menuId: item.menuId,
            quantity: item.quantity
          })),
          deliveryAddress: orderForm.deliveryAddress,
          phone: orderForm.phone,
          remark: orderForm.remark
        }
        
        await orderApi.create(orderData)
        ElMessage.success('订单创建成功')
        cartStore.clearCart()
        showCheckoutDialog.value = false
        router.push('/order')
      } catch (error: any) {
        ElMessage.error(error.message || '创建订单失败')
      } finally {
        submitting.value = false
      }
    }
  })
}
</script>

<style scoped>
.cart {
  background: white;
  padding: 20px;
  border-radius: 8px;
}

.cart h2 {
  margin-bottom: 20px;
}

.menu-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.menu-image {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
}

.price {
  color: #f56c6c;
  font-weight: bold;
}

.cart-footer {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.total {
  font-size: 18px;
}

.total-price {
  color: #f56c6c;
  font-size: 24px;
  font-weight: bold;
  margin-left: 10px;
}
</style>
