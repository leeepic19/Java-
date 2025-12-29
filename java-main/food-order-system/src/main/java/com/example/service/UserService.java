package com.example.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.User;
import com.example.entity.UserAddress;
import com.example.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户注册
     */
    public boolean register(User user) {
        // 先判断用户名是否已存在
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", user.getUsername());
        User existUser = userMapper.selectOne(wrapper);
        if (existUser != null) {
            return false; // 用户名已存在
        }
        // 插入新用户（BaseMapper<User> 原生方法，仅操作User实体，无问题）
        return userMapper.insert(user) > 0;
    }

    /**
     * 用户登录
     */
    public User login(String username, String password, Integer userType) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username)
                .eq("password", password)
                .eq("user_type", userType);
        return userMapper.selectOne(wrapper);
    }

    // ======================== 重构后地址操作逻辑（无类型不兼容） ========================
    /**
     * 添加用户收货地址：若无地址则自动设为默认
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean addUserAddress(UserAddress address) {
        if (address == null || address.getUserId() == null || address.getUserId() <= 0) {
            return false; // 参数非法
        }
        // 1. 改用手动SQL查询用户地址数量（替代selectList + LambdaQueryWrapper）
        Integer addressCount = userMapper.countUserAddress(address.getUserId());
        // 2. 若无地址，自动设为默认地址（is_default=1）
        if (addressCount == 0) {
            address.setIsDefault(1);
        } else {
            address.setIsDefault(0); // 有地址则默认设为非默认
        }
        // 3. 调用手动编写的insertAddress方法插入地址
        return userMapper.insertAddress(address) > 0;
    }

    /**
     * 设置默认地址：重置该用户原有默认地址，仅保留当前地址为默认
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean setDefaultAddress(Long userId, Long addressId) {
        if (userId == null || userId <= 0 || addressId == null || addressId <= 0) {
            return false; // 参数非法
        }
        // 1. 改用手动SQL校验地址是否属于该用户（替代selectById）
        UserAddress address = userMapper.selectAddressById(addressId);
        if (address == null || !userId.equals(address.getUserId())) {
            return false; // 地址不存在或不属于该用户
        }
        // 2. 改用手动SQL将该用户所有地址设为非默认（替代update + LambdaQueryWrapper）
        userMapper.resetAllNonDefaultAddress(userId);
        // 3. 改用手动SQL将目标地址设为默认（替代updateById）
        return userMapper.updateAddressToDefault(addressId) > 0;
    }

    /**
     * 查询用户默认收货地址（供下单逻辑调用）
     */
    public UserAddress getUserDefaultAddress(Long userId) {
        if (userId == null || userId <= 0) {
            return null;
        }
        // 调用原有手动编写的默认地址查询方法
        return userMapper.selectUserDefaultAddress(userId);
    }
}