package com.example.controller;

import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 注册接口
     */
    @PostMapping("/register")
    public Map<String, Object> register(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam Integer userType) {
        Map<String, Object> result = new HashMap<>();
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setUserType(userType);
        boolean success = userService.register(user);
        if (success) {
            result.put("code", 200);
            result.put("msg", "注册成功");
        } else {
            result.put("code", 500);
            result.put("msg", "用户名已存在，注册失败");
        }
        return result;
    }

    /**
     * 登录接口
     */
    @PostMapping("/login")
    public Map<String, Object> login(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam Integer userType) {
        Map<String, Object> result = new HashMap<>();
        User user = userService.login(username, password, userType);
        if (user != null) {
            result.put("code", 200);
            result.put("msg", "登录成功");
            result.put("data", user); // 返回用户信息（不含密码，简易版暂直接返回）
        } else {
            result.put("code", 500);
            result.put("msg", "用户名、密码或用户类型错误，登录失败");
        }
        return result;
    }
}