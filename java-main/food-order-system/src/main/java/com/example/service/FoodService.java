package com.example.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.Food;
import com.example.mapper.FoodMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class FoodService {
    @Autowired
    private FoodMapper foodMapper;

    @Value("${upload.path}")
    private String uploadPath;

    /**
     * 新增：根据餐品ID查询餐品信息（用于下单前库存校验）
     */
    public Food getFoodById(Long foodId) { // 修改：Integer → Long
        return foodMapper.selectById(foodId);
    }

    /**
     * 商家上传餐品
     */
    public boolean uploadFood(Food food, MultipartFile file) throws IOException {
        // 处理图片上传
        if (!file.isEmpty()) {
            // 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            // 防止文件名为空导致的空指针异常
            if (originalFilename == null || originalFilename.lastIndexOf(".") == -1) {
                throw new RuntimeException("无效的图片文件，缺少文件后缀");
            }
            String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + suffix;

            // 创建上传目录
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 关键修复：使用File.separator拼接路径，兼容Windows/Linux系统
            File destFile = new File(uploadDir, newFileName);
            // 保存图片
            file.transferTo(destFile);

            // 确保数据库存储的是与upload目录一致的唯一文件名（核心：解决名称不一致问题）
            food.setFoodImg(newFileName);
        }
        // 插入餐品
        return foodMapper.insert(food) > 0;
    }

    /**
     * 修改餐品库存
     */
    public boolean updateFoodStock(Long foodId, Integer stock) { // 修改：Integer → Long
        Food food = new Food();
        food.setId(foodId);
        food.setStock(stock);
        return foodMapper.updateById(food) > 0;
    }

    /**
     * 查询所有餐品（用户端使用）
     */
    public List<Food> getAllFood() {
        return foodMapper.selectList(null);
    }

    /**
     * 查询商家自己的餐品
     */
    public List<Food> getMerchantFood(Long merchantId) { // 修改：Integer → Long
        QueryWrapper<Food> wrapper = new QueryWrapper<>();
        wrapper.eq("merchant_id", merchantId);
        return foodMapper.selectList(wrapper);
    }
}