package com.wsdc.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "tb_user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "user_name", nullable = false, length = 30)
    private String userName;

    @Column(name = "user_password", nullable = false, length = 30)
    private String userPassword;

    @Column(name = "user_realname", length = 50)
    private String userRealname;

    @Column(name = "user_sex", length = 30)
    private String userSex;

    @Column(name = "user_flag", nullable = false, length = 4)
    private String userFlag;

    @Column(name = "user_mail", nullable = false, length = 50)
    private String userMail;
}
