package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 餐品（商品）实体类
 * 对应数据库 food 表
 */
@Data
@TableName("t_food")
public class Food {
    @TableId(type = IdType.AUTO)
    private Long id;         // 修改：Integer → Long（匹配数据库BIGINT类型）
    private Long merchantId; // 修改：Integer → Long（匹配数据库BIGINT类型）
    private String merchantName;// 商家名称（新增：用于商品展示）
    private String foodName;    // 餐品名称
    private BigDecimal price;   // 餐品价格
    private Integer stock;      // 库存
    private String foodImg;     // 图片路径
    private Date createTime;    // 创建时间
}