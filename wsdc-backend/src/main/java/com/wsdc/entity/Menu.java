package com.wsdc.entity;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "tb_menu")
public class Menu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "menu_id")
    private Long menuId;

    @Column(name = "menu_name", nullable = false, length = 50)
    private String menuName;

    @Column(name = "menu_content", length = 50)
    private String menuContent;

    @Column(name = "menu_price", nullable = false, precision = 5, scale = 2)
    private BigDecimal menuPrice;

    @Column(name = "menu_image", length = 255)
    private String menuImage;
}
