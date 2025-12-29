package com.example.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.entity.Food;
import com.example.entity.OrderInfo;
import com.example.entity.UserAddress;
import com.example.mapper.OrderInfoMapper;
import com.example.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderInfoService {
    @Autowired
    private OrderInfoMapper orderInfoMapper;
    @Autowired
    private FoodService foodService;
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户下单（整合库存扣减、收货信息自动入库、地址兜底，带事务保障）
     * 核心修复：确保商家ID赋值有效、订单插入t_order表无异常
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> createOrderWithStock(OrderInfo orderInfo) {
        Map<String, Object> result = new HashMap<>();

        // 1. 基础参数+收货信息校验
        if (orderInfo.getUserId() == null || orderInfo.getUserId() <= 0 ||
                orderInfo.getFoodId() == null || orderInfo.getFoodId() <= 0 ||
                orderInfo.getOrderNum() == null || orderInfo.getOrderNum() <= 0 ||
                orderInfo.getUserName() == null || orderInfo.getUserName().trim().isEmpty() ||
                orderInfo.getUserPhone() == null || orderInfo.getUserPhone().trim().isEmpty() ||
                orderInfo.getUserAddress() == null || orderInfo.getUserAddress().trim().isEmpty()) {
            result.put("code", 400);
            result.put("msg", "参数不合法：请填写完整的收货信息（姓名、手机号、地址不能为空），订单信息需有效");
            return result;
        }

        // 2. 校验餐品是否存在及库存是否充足
        Food food = foodService.getFoodById(orderInfo.getFoodId());
        if (food == null) {
            result.put("code", 500);
            result.put("msg", "餐品不存在，无法下单");
            return result;
        }
        if (food.getStock() < orderInfo.getOrderNum()) {
            result.put("code", 500);
            result.put("msg", "库存不足！当前库存：" + food.getStock() + "，下单数量：" + orderInfo.getOrderNum());
            return result;
        }

        // ===================== 核心新增：前端地址自动入库 =====================
        Long currentUserId = orderInfo.getUserId();
        // 先查询用户是否有地址
        Integer addressCount = userMapper.countUserAddress(currentUserId);
        if (addressCount == 0) {
            // 无地址 → 把前端填的收货信息自动插入t_user_address表
            UserAddress newAddress = new UserAddress();
            newAddress.setUserId(currentUserId);
            newAddress.setReceiver(orderInfo.getUserName()); // 前端填的收货人
            newAddress.setPhone(orderInfo.getUserPhone());   // 前端填的手机号
            // 【可选】若前端未拆分省市区，临时填充默认值（建议后续前端加省市区输入框）
            newAddress.setProvince("默认省");
            newAddress.setCity("默认市");
            newAddress.setDistrict("默认区");
            newAddress.setDetailAddress(orderInfo.getUserAddress()); // 前端填的详细地址
            newAddress.setIsDefault(1); // 设为默认地址
            // 插入地址到数据库
            userMapper.insertAddress(newAddress);
        }

        // 3. 地址兜底逻辑（适配所有用户）
        UserAddress defaultAddress = userMapper.selectUserDefaultAddress(currentUserId);
        if (defaultAddress == null) {
            // 有地址但无默认 → 自动将第一条地址设为默认
            UserAddress firstAddress = userMapper.selectFirstAddress(currentUserId);
            userMapper.resetAllNonDefaultAddress(currentUserId);
            userMapper.updateAddressToDefault(firstAddress.getId());
            defaultAddress = firstAddress;
        }
        // 赋值地址ID（无论是否兜底，确保有值）
        orderInfo.setAddressId(defaultAddress.getId());

        // 4. 补充订单完整信息（核心修复：校验商家ID有效性）
        Long merchantId = food.getMerchantId();
        // 强制校验商家ID（必须是有效商家ID，即2）
        if (merchantId == null || merchantId <= 0) {
            result.put("code", 500);
            result.put("msg", "餐品未关联有效商家，无法下单");
            return result;
        }
        orderInfo.setFoodName(food.getFoodName());
        orderInfo.setMerchantId(merchantId); // 确保赋值有效商家ID=2
        orderInfo.setMerchantName(food.getMerchantName());
        orderInfo.setOrderTime(new Date());
        orderInfo.setStatus(0); // 0=待商家处理（强制赋值，避免空值）
        orderInfo.setDeliveryTime(null);

        // 5. 创建订单（调用修复后的insertOrder，确保插入t_order表）
        boolean orderSuccess = orderInfoMapper.insertOrder(orderInfo) > 0;
        if (!orderSuccess) {
            throw new RuntimeException("订单创建失败：插入t_order表失败");
        }

        // 6. 扣减库存
        Integer newStock = food.getStock() - orderInfo.getOrderNum();
        boolean stockSuccess = foodService.updateFoodStock(orderInfo.getFoodId(), newStock);
        if (!stockSuccess) {
            throw new RuntimeException("库存扣减失败");
        }

        // 7. 下单成功返回结果（新增商家ID，便于调试）
        result.put("code", 200);
        result.put("msg", "下单成功！等待商家处理");
        result.put("orderId", orderInfo.getId());
        result.put("merchantId", merchantId); // 新增：返回关联的商家ID，验证是否为2
        result.put("newStock", newStock);
        return result;
    }

    /**
     * 保留原有下单方法（兼容旧逻辑）
     * 修复：改为调用insertOrder，确保插入t_order表而非默认表
     */
    public boolean createOrder(OrderInfo orderInfo) {
        return orderInfoMapper.insertOrder(orderInfo) > 0;
    }

    /**
     * 查询商家待处理订单
     * 核心修复：优先使用原生SQL查询，备用Wrapper查询，双重保障商家能查到订单
     */
    public List<OrderInfo> getMerchantPendingOrders(Long merchantId) {
        // 强制校验商家ID（必须是有效值，正确值为2）
        if (merchantId == null || merchantId <= 0) {
            throw new IllegalArgumentException("商家ID无效：请传入大于0的数值（正确商家ID为2）");
        }

        // 优先调用Mapper原生SQL方法（精准查询t_order表）
        try {
            return orderInfoMapper.selectPendingOrdersByMerchantId(merchantId);
        } catch (Exception e) {
            // 备用逻辑：使用Wrapper查询（确保匹配t_order表）
            LambdaQueryWrapper<OrderInfo> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(OrderInfo::getMerchantId, merchantId)
                    .eq(OrderInfo::getStatus, 0)
                    .orderByDesc(OrderInfo::getOrderTime);
            return orderInfoMapper.selectList(queryWrapper);
        }
    }

    /**
     * 商家确认发货
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> merchantConfirmDelivery(Long orderId, Integer deliveryTime) {
        Map<String, Object> result = new HashMap<>();
        if (orderId == null || orderId <= 0 || deliveryTime == null || deliveryTime <= 0) {
            result.put("code", 400);
            result.put("msg", "参数不合法：订单ID无效，预计送达时间必须大于0");
            return result;
        }

        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
        if (orderInfo == null) {
            result.put("code", 500);
            result.put("msg", "订单不存在，无法发货");
            return result;
        }
        if (orderInfo.getStatus() != 0) {
            result.put("code", 400);
            result.put("msg", "该订单已处理（非待处理状态），无法重复发货");
            return result;
        }

        orderInfo.setStatus(1);
        orderInfo.setDeliveryTime(deliveryTime);
        boolean updateSuccess = orderInfoMapper.updateById(orderInfo) > 0;

        if (updateSuccess) {
            result.put("code", 200);
            result.put("msg", "发货成功！预计" + deliveryTime + "分钟到达");
        } else {
            result.put("code", 500);
            result.put("msg", "发货失败：订单状态更新失败");
        }
        return result;
    }

    /**
     * 商家拒单（恢复库存）
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> merchantRejectOrder(Long orderId) {
        Map<String, Object> result = new HashMap<>();
        if (orderId == null || orderId <= 0) {
            result.put("code", 400);
            result.put("msg", "参数不合法：订单ID无效");
            return result;
        }

        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
        if (orderInfo == null) {
            result.put("code", 500);
            result.put("msg", "订单不存在，无法拒单");
            return result;
        }
        if (orderInfo.getStatus() != 0) {
            result.put("code", 400);
            result.put("msg", "该订单已处理（非待处理状态），无法重复拒单");
            return result;
        }

        // 恢复库存
        Food food = foodService.getFoodById(orderInfo.getFoodId());
        if (food != null) {
            Integer recoverStock = food.getStock() + orderInfo.getOrderNum();
            foodService.updateFoodStock(orderInfo.getFoodId(), recoverStock);
        }

        // 更新拒单状态
        orderInfo.setStatus(3);
        boolean updateSuccess = orderInfoMapper.updateById(orderInfo) > 0;

        if (updateSuccess) {
            result.put("code", 200);
            result.put("msg", "拒单成功！用户将收到“商家有事暂时不能发货”提示");
        } else {
            result.put("code", 500);
            result.put("msg", "拒单失败：订单状态更新失败");
        }
        return result;
    }

    /**
     * 用户确认送达
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> userConfirmArrival(Long orderId) {
        Map<String, Object> result = new HashMap<>();
        if (orderId == null || orderId <= 0) {
            result.put("code", 400);
            result.put("msg", "参数不合法：订单ID无效");
            return result;
        }

        OrderInfo orderInfo = orderInfoMapper.selectById(orderId);
        if (orderInfo == null) {
            result.put("code", 500);
            result.put("msg", "订单不存在，无法确认送达");
            return result;
        }
        if (orderInfo.getStatus() != 1) {
            result.put("code", 400);
            result.put("msg", "商家尚未发货，无法确认送达");
            return result;
        }

        orderInfo.setStatus(2);
        boolean updateSuccess = orderInfoMapper.updateById(orderInfo) > 0;

        if (updateSuccess) {
            result.put("code", 200);
            result.put("msg", "确认送达成功！订单已完成，商家将收到完成消息");
        } else {
            result.put("code", 500);
            result.put("msg", "确认送达失败：订单状态更新失败");
        }
        return result;
    }

    /**
     * 查询用户所有订单
     */
    public List<OrderInfo> getUserOrders(Long userId) {
        LambdaQueryWrapper<OrderInfo> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(OrderInfo::getUserId, userId)
                .orderByDesc(OrderInfo::getOrderTime);
        return orderInfoMapper.selectList(queryWrapper);
    }

    /**
     * 查询商家所有订单
     * 核心修复：校验商家ID有效性，确保查询正确
     */
    public List<OrderInfo> getMerchantAllOrders(Long merchantId) {
        if (merchantId == null || merchantId <= 0) {
            throw new IllegalArgumentException("商家ID无效：请传入大于0的数值（正确商家ID为2）");
        }
        LambdaQueryWrapper<OrderInfo> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(OrderInfo::getMerchantId, merchantId)
                .orderByDesc(OrderInfo::getOrderTime);
        return orderInfoMapper.selectList(queryWrapper);
    }
}