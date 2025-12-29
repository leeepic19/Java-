package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

/**
 * 用户收货地址实体类
 * 对应数据库 t_user_address 表
 */
@Data
@TableName("t_user_address")
public class UserAddress {
    @TableId(type = IdType.AUTO)
    private Long id; // 地址ID
    private Long userId; // 所属用户ID
    private String receiver; // 收货人
    private String phone; // 收货手机号
    private String province; // 省
    private String city; // 市
    private String district; // 区/县
    private String detailAddress; // 详细地址
    private Integer isDefault; // 是否默认地址：0-否，1-是
    private Date createTime; // 创建时间
    private Date updateTime; // 更新时间
}