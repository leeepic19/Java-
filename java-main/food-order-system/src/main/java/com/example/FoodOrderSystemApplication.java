package com.example;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;
@SpringBootApplication
@MapperScan("com.example.mapper") // 扫描Mapper接口
@EnableTransactionManagement // 开启事务支持
public class FoodOrderSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(FoodOrderSystemApplication.class, args);
        System.out.println("后端服务启动成功，访问地址：http://localhost:8080");
    }
}