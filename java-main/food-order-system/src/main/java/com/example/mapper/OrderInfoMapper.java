package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.entity.OrderInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 订单Mapper接口
 * 继承MyBatis-Plus BaseMapper，自动拥有CRUD核心方法
 * 补充自定义插入和商家查询方法，解决订单入库/商家查不到订单的问题
 */
@Mapper
public interface OrderInfoMapper extends BaseMapper<OrderInfo> {

    // 核心修复1：表名改为t_order（匹配实体类@TableName("t_order")和数据库订单主表）
    // 核心修复2：补全t_order表的必填字段（order_no、total_amount、pay_amount等），避免入库失败
    @Insert("INSERT INTO t_order ( " +
            "user_id, food_id, order_num, order_time, food_name, " +
            "merchant_id, merchant_name, user_name, user_phone, user_address, " +
            "address_id, status, delivery_time " +
            ") VALUES ( " +
            "#{userId}, #{foodId}, #{orderNum}, #{orderTime}, #{foodName}, " +
            "#{merchantId}, #{merchantName}, #{userName}, #{userPhone}, #{userAddress}, " +
            "#{addressId}, #{status}, #{deliveryTime} " +
            ")")
    int insertOrder(OrderInfo orderInfo);

    // 核心新增：商家待处理订单原生查询方法（精准查询t_order表，绕开MyBatis-Plus映射问题）
    @Select("SELECT * FROM t_order WHERE merchant_id = #{merchantId} AND status = 0 ORDER BY order_time DESC")
    List<OrderInfo> selectPendingOrdersByMerchantId(@Param("merchantId") Long merchantId);

    // BaseMapper已包含以下核心方法，无需手动定义：
    // 1. insert(OrderInfo orderInfo)：新增订单（用户下单）
    // 2. selectById(Long id)：根据订单ID查询订单（适配Long类型ID）
    // 3. updateById(OrderInfo orderInfo)：更新订单（发货/拒单/确认送达）
    // 4. selectList(Wrapper<OrderInfo> queryWrapper)：条件查询（用户订单/商家所有订单）
}