package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.entity.Food;
import com.example.entity.FoodVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 餐品Mapper接口（基于MyBatis-Plus扩展）
 */
@Mapper
public interface FoodMapper extends BaseMapper<Food> {

    /**
     * 根据商家ID查询餐品列表（含商家名称，修正字段映射）
     * @param merchantId 商家ID
     * @return 餐品VO列表（包含商家名称和图片映射）
     */
    @Select("SELECT " +
            "f.id, " +
            "f.merchant_id, " +
            "u.nickname AS merchant_name, " +  // 关联t_user表获取商家名称，别名对应VO的merchantName
            "f.food_name, " +
            "f.price, " +
            "f.stock, " +
            "f.picture_url AS food_img, " +    // 映射为food_img，对应VO的foodImg
            "f.create_time " +
            "FROM t_food f " +
            "LEFT JOIN t_user u ON f.merchant_id = u.id " +  // 关联商家表
            "WHERE f.merchant_id = #{merchantId}")
    List<FoodVO> getFoodListByMerchantId(@Param("merchantId") Long merchantId);

}