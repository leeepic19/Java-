package com.wsdc.dto;

import lombok.Data;

@Data
public class UserResponse {
    private Long userId;
    private String userName;
    private String userRealname;
    private String userSex;
    private String userFlag;
    private String userMail;
}
