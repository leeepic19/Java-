package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

/**
 * 订单实体类
 * 对应数据库 t_order 表
 * 包含收货信息、订单状态、商家/商品信息、配送信息等核心字段
 */
@Data
@TableName("t_order") // 修改：order_info → t_order（匹配新创建的订单表）
public class OrderInfo {
    @TableId(type = IdType.AUTO)
    private Long id;         // 修改：Integer → Long（匹配数据库BIGINT类型）
    private Long userId;     // 修改：Integer → Long（匹配数据库BIGINT类型）
    private Long foodId;     // 修改：Integer → Long（匹配数据库BIGINT类型）
    private Integer orderNum;   // 下单数量
    private Date orderTime;     // 下单时间

    // 新增：商品/商家信息（冗余存储，便于展示，无需关联查询）
    private String foodName;    // 餐品名称
    private Long merchantId; // 修改：Integer → Long（匹配数据库BIGINT类型）
    private String merchantName;// 商家名称

    // 新增：用户收货信息（用户下单时需填写）
    private String userName;    // 收货人姓名
    private String userPhone;   // 收货人手机号
    private String userAddress; // 收货人地址

    // 新增：收货地址ID（关联t_user_address表，解决非空约束问题）
    private Long addressId;     // 收货地址ID

    // 新增：订单状态与配送信息（满足订单流转需求）
    private Integer status;     // 订单状态：0=待商家处理，1=商家已发货，2=用户已确认送达，3=商家拒单
    private Integer deliveryTime; // 预计送达时间（分钟，商家发货时填写）
}