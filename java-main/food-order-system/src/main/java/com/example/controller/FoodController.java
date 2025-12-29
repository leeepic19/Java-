package com.example.controller;

import com.example.entity.Food;
import com.example.service.FoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 餐品（商品）管理控制器
 * 负责餐品上传、库存修改、商品查询（展示商品名+商家名）
 */
@CrossOrigin(origins = "*") // 新增：允许跨域，解决前端调用接口跨域问题
@RestController
@RequestMapping("/food") // 统一接口前缀，规范路径
public class FoodController {
    @Autowired
    private FoodService foodService;

    /**
     * 商家上传餐品（含商家名称填写）
     */
    @PostMapping("/upload")
    public Map<String, Object> uploadFood(
            @RequestParam Long merchantId, // 修改：Integer → Long
            @RequestParam String merchantName, // 新增：商家名称，存入food表
            @RequestParam String foodName,
            @RequestParam Double price,
            @RequestParam Integer stock,
            @RequestParam MultipartFile foodImg) {
        Map<String, Object> result = new HashMap<>();

        // 简单参数校验
        if (merchantId == null || merchantId <= 0 ||
                merchantName == null || merchantName.trim().isEmpty() ||
                foodName == null || foodName.trim().isEmpty() ||
                price == null || price < 0 ||
                stock == null || stock < 0 ||
                foodImg.isEmpty()) {
            result.put("code", 400);
            result.put("msg", "参数不合法：请填写完整有效信息，图片不可为空");
            return result;
        }

        Food food = new Food();
        food.setMerchantId(merchantId);
        food.setMerchantName(merchantName.trim()); // 保存商家名称
        food.setFoodName(foodName.trim());
        food.setPrice(BigDecimal.valueOf(price)); // 优化BigDecimal转换，避免空指针
        food.setStock(stock);

        try {
            boolean success = foodService.uploadFood(food, foodImg);
            if (success) {
                result.put("code", 200);
                result.put("msg", "餐品上传成功");
            } else {
                result.put("code", 500);
                result.put("msg", "餐品上传失败");
            }
        } catch (IOException e) {
            result.put("code", 500);
            result.put("msg", "图片上传失败：" + e.getMessage());
        }
        return result;
    }

    /**
     * 修改餐品库存
     */
    @PostMapping("/updateStock")
    public Map<String, Object> updateStock(
            @RequestParam Long foodId, // 修改：Integer → Long
            @RequestParam Integer stock) {
        Map<String, Object> result = new HashMap<>();

        // 参数校验
        if (foodId == null || foodId <= 0 || stock == null || stock < 0) {
            result.put("code", 400);
            result.put("msg", "参数不合法：餐品ID需大于0，库存不可为负数");
            return result;
        }

        boolean success = foodService.updateFoodStock(foodId, stock);
        if (success) {
            result.put("code", 200);
            result.put("msg", "库存修改成功");
        } else {
            result.put("code", 500);
            result.put("msg", "库存修改失败");
        }
        return result;
    }

    /**
     * 查询所有餐品（用户端，展示商品名+商家名）
     */
    @GetMapping("/list")
    public Map<String, Object> getAllFood() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Food> foodList = foodService.getAllFood();
            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", foodList); // 统一返回格式，便于前端处理
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询所有餐品失败：" + e.getMessage());
        }
        return result;
    }

    /**
     * 查询商家自己的餐品
     */
    @GetMapping("/merchantList")
    public Map<String, Object> getMerchantFood(@RequestParam Long merchantId) { // 修改：Integer → Long
        Map<String, Object> result = new HashMap<>();

        // 参数校验
        if (merchantId == null || merchantId <= 0) {
            result.put("code", 400);
            result.put("msg", "参数不合法：商家ID需大于0");
            return result;
        }

        try {
            List<Food> merchantFoodList = foodService.getMerchantFood(merchantId);
            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", merchantFoodList);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询商家餐品失败：" + e.getMessage());
        }
        return result;
    }
}