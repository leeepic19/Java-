package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("t_user")
public class User {
    @TableId(type = IdType.AUTO)
    private Integer id;         // 用户ID
    private String username;    // 用户名
    private String password;    // 密码
    private Integer userType;   // 用户类型：1=普通用户，2=商家
    private Date createTime;    // 创建时间
}