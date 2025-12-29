package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.entity.User;
import com.example.entity.UserAddress;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper extends BaseMapper<User> {

    // 1. 查询用户默认收货地址（原有）
    @Select("SELECT id, user_id, receiver, phone, province, city, district, detail_address, is_default, create_time, update_time " +
            "FROM t_user_address WHERE user_id = #{userId} AND is_default = 1 LIMIT 1")
    UserAddress selectUserDefaultAddress(@Param("userId") Long userId);

    // 2. 插入用户收货地址（核心修复：把#{detail_address}改为#{detailAddress}）
    @Insert("INSERT INTO t_user_address (user_id, receiver, phone, province, city, district, detail_address, is_default, create_time, update_time) " +
            "VALUES (#{userId}, #{receiver}, #{phone}, #{province}, #{city}, #{district}, #{detailAddress}, #{isDefault}, NOW(), NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertAddress(UserAddress address);

    // 3. 新增：查询用户地址数量（判断是否有地址）
    @Select("SELECT COUNT(*) FROM t_user_address WHERE user_id = #{userId}")
    Integer countUserAddress(@Param("userId") Long userId);

    // 4. 新增：查询用户第一条地址（无默认时兜底核心方法）
    @Select("SELECT id, user_id, receiver, phone, province, city, district, detail_address, is_default, create_time, update_time " +
            "FROM t_user_address WHERE user_id = #{userId} LIMIT 1")
    UserAddress selectFirstAddress(@Param("userId") Long userId);

    // 5. 新增：根据ID查询地址（备用）
    @Select("SELECT id, user_id, receiver, phone, province, city, district, detail_address, is_default, create_time, update_time " +
            "FROM t_user_address WHERE id = #{addressId}")
    UserAddress selectAddressById(@Param("addressId") Long addressId);

    // 6. 新增：重置用户所有地址为非默认
    @Update("UPDATE t_user_address SET is_default = 0, update_time = NOW() WHERE user_id = #{userId}")
    void resetAllNonDefaultAddress(@Param("userId") Long userId);

    // 7. 新增：设置指定地址为默认
    @Update("UPDATE t_user_address SET is_default = 1, update_time = NOW() WHERE id = #{addressId}")
    int updateAddressToDefault(@Param("addressId") Long addressId);
}