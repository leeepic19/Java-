package com.example.controller;

import com.example.entity.OrderInfo;
import com.example.service.OrderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "*") // 允许跨域，解决前端调用接口跨域问题
@RestController
public class OrderController {
    @Autowired
    private OrderInfoService orderInfoService;

    /**
     * 用户下单（保留原始逻辑，确保订单能正确关联商家ID）
     */
    @PostMapping("/order/create")
    public Map<String, Object> createOrder(
            @RequestParam Long userId,
            @RequestParam Long foodId,
            @RequestParam Integer orderNum,
            @RequestParam String userName,
            @RequestParam String userPhone,
            @RequestParam String userAddress) {
        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setUserId(userId);
        orderInfo.setFoodId(foodId);
        orderInfo.setOrderNum(orderNum);
        orderInfo.setUserName(userName);
        orderInfo.setUserPhone(userPhone);
        orderInfo.setUserAddress(userAddress);
        // 调用修复后的下单方法，确保订单插入t_order表并关联商家ID=2
        return orderInfoService.createOrderWithStock(orderInfo);
    }

    /**
     * 查询商家待处理订单（核心优化：明确提示商家ID填写错误，便于调试）
     */
    @GetMapping("/order/merchant/pending")
    public Map<String, Object> getMerchantPendingOrders(@RequestParam Long merchantId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 校验商家ID是否为2（明确提示正确值）
            if (merchantId != 2L) {
                result.put("code", 400);
                result.put("msg", "商家ID错误！正确商家ID为2，请传入merchantId=2");
                return result;
            }
            List<OrderInfo> pendingOrders = orderInfoService.getMerchantPendingOrders(merchantId);
            result.put("code", 200);
            result.put("msg", "查询商家待处理订单成功");
            result.put("count", pendingOrders.size()); // 新增：返回订单数量，更直观
            result.put("data", pendingOrders);
        } catch (IllegalArgumentException e) {
            result.put("code", 400);
            result.put("msg", "查询失败：" + e.getMessage());
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询失败：服务器内部异常");
            e.printStackTrace(); // 打印异常日志，便于后端排查
        }
        return result;
    }

    /**
     * 商家确认发货
     */
    @PostMapping("/order/merchant/confirm-delivery")
    public Map<String, Object> merchantConfirmDelivery(
            @RequestParam Long orderId,
            @RequestParam Integer deliveryTime) {
        return orderInfoService.merchantConfirmDelivery(orderId, deliveryTime);
    }

    /**
     * 商家拒单
     */
    @PostMapping("/order/merchant/reject")
    public Map<String, Object> merchantRejectOrder(@RequestParam Long orderId) {
        return orderInfoService.merchantRejectOrder(orderId);
    }

    /**
     * 用户确认送达
     */
    @PostMapping("/order/user/confirm-arrival")
    public Map<String, Object> userConfirmArrival(@RequestParam Long orderId) {
        return orderInfoService.userConfirmArrival(orderId);
    }

    /**
     * 查询用户所有订单
     */
    @GetMapping("/order/user/list")
    public Map<String, Object> getUserOrders(@RequestParam Long userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<OrderInfo> userOrders = orderInfoService.getUserOrders(userId);
            result.put("code", 200);
            result.put("msg", "查询用户订单成功");
            result.put("count", userOrders.size());
            result.put("data", userOrders);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询失败：" + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 查询商家所有订单（优化：提示正确商家ID）
     */
    @GetMapping("/order/merchant/all")
    public Map<String, Object> getMerchantAllOrders(@RequestParam Long merchantId) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (merchantId != 2L) {
                result.put("code", 400);
                result.put("msg", "商家ID错误！正确商家ID为2，请传入merchantId=2");
                return result;
            }
            List<OrderInfo> merchantOrders = orderInfoService.getMerchantAllOrders(merchantId);
            result.put("code", 200);
            result.put("msg", "查询商家所有订单成功");
            result.put("count", merchantOrders.size());
            result.put("data", merchantOrders);
        } catch (IllegalArgumentException e) {
            result.put("code", 400);
            result.put("msg", "查询失败：" + e.getMessage());
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询失败：服务器内部异常");
            e.printStackTrace();
        }
        return result;
    }
}