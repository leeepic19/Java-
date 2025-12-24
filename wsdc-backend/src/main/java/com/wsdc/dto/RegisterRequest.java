package com.wsdc.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
public class RegisterRequest {
    @NotBlank(message = "Username cannot be empty")
    @Size(min = 3, max = 30, message = "Username length must be between 3-30")
    private String userName;

    @NotBlank(message = "Password cannot be empty")
    @Size(min = 6, max = 30, message = "Password length must be between 6-30")
    private String userPassword;

    private String userMail;
}
