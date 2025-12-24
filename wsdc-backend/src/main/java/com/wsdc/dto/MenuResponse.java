package com.wsdc.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class MenuResponse {
    private Long menuId;
    private String menuName;
    private String menuContent;
    private BigDecimal menuPrice;
    private String menuImage;
}
