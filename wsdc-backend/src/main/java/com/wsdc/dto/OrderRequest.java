package com.wsdc.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class OrderRequest {
    @NotNull(message = "Menu ID cannot be empty")
    private Long menuId;

    @NotNull(message = "Quantity cannot be empty")
    private Integer orderNum;

    private String orderNotice;  // 口味要求

    private String otherNotice;  // 其他要求
}
