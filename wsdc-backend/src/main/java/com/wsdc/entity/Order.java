package com.wsdc.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "tb_orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long orderId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "menu_id", nullable = false)
    private Long menuId;

    @Column(name = "order_num", nullable = false)
    private Integer orderNum;

    @Column(name = "order_notice", length = 45)
    private String orderNotice;

    @Column(name = "other_notice", length = 100)
    private String otherNotice;

    @Column(name = "states", nullable = false, length = 4)
    private String states;
}
