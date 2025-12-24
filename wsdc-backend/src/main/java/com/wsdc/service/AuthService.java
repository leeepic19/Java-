package com.wsdc.service;

import com.wsdc.dto.LoginRequest;
import com.wsdc.dto.RegisterRequest;
import com.wsdc.dto.UserResponse;
import com.wsdc.entity.User;
import com.wsdc.repository.UserRepository;
import com.wsdc.util.JwtUtil;
import com.wsdc.util.MD5Util;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuthService {
    
    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;

    @Transactional
    public Map<String, Object> login(LoginRequest request) {
        User user = userRepository.findByUserName(request.getUserName())
                .orElseThrow(() -> new RuntimeException("User does not exist"));

        String encryptedPassword = MD5Util.encrypt(request.getUserPassword());
        if (!encryptedPassword.equals(user.getUserPassword())) {
            throw new RuntimeException("Password incorrect");
        }

        String token = jwtUtil.generateToken(user.getUserName());
        UserResponse userResponse = convertToResponse(user);

        Map<String, Object> result = new HashMap<>();
        result.put("token", token);
        result.put("user", userResponse);
        return result;
    }

    @Transactional
    public UserResponse register(RegisterRequest request) {
        if (userRepository.existsByUserName(request.getUserName())) {
            throw new RuntimeException("Username already exists");
        }

        User user = new User();
        user.setUserName(request.getUserName());
        user.setUserPassword(MD5Util.encrypt(request.getUserPassword()));
        user.setUserRealname(request.getUserName());
        user.setUserSex("未知");
        user.setUserFlag("普通用户");
        user.setUserMail(request.getUserMail() != null ? request.getUserMail() : "");

        user = userRepository.save(user);
        return convertToResponse(user);
    }

    public UserResponse getCurrentUser(String username) {
        User user = userRepository.findByUserName(username)
                .orElseThrow(() -> new RuntimeException("User does not exist"));
        return convertToResponse(user);
    }

    private UserResponse convertToResponse(User user) {
        UserResponse response = new UserResponse();
        BeanUtils.copyProperties(user, response);
        return response;
    }
}
