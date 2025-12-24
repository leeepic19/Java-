package com.wsdc.dto;

import lombok.Data;

@Data
public class OrderResponse {
    private Long orderId;
    private Long userId;
    private Long menuId;
    private String menuName;  // 从菜单表查询
    private Integer orderNum;
    private String orderNotice;
    private String otherNotice;
    private String states;  // 订单状态
}
