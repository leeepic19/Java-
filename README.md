# 🥡 Food Order System (餐饮点餐系统)

<div align="center">

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.0-brightgreen?style=for-the-badge&logo=springboot)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![jQuery](https://img.shields.io/badge/jQuery-3.6.4-0769AD?style=for-the-badge&logo=jquery)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

**一个基于 Spring Boot 和 Vue/jQuery 的现代化餐饮点餐系统**

[查看演示](#-界面展示) • [快速开始](#-快速开始) • [功能特性](#-功能特性) • [技术栈](#-技术栈)

</div>

---

## 📖 项目简介

**Food Order System** 是一个轻量级、前后端分离设计的餐饮点餐平台。它旨在为餐饮商家提供高效的订单管理工具，同时为顾客提供流畅的在线点餐体验。

本项目采用经典的 **B/S 架构** 和 **MVC 设计模式**，后端基于 **Spring Boot 3.4.0** 构建，前端采用 **HTML5 + jQuery** 开发，界面融入了现代化的 **Glassmorphism (玻璃拟态)** 设计风格。

> 🛡️ **安全增强**: 本项目特别注重安全性，已修复多个已知 CVE 漏洞，并集成了自定义过滤器以防御路径遍历攻击。

## ✨ 功能特性

### 👤 顾客端 (Customer)
- [x] **账户体系**: 用户注册、登录、个人信息管理。
- [x] **浏览菜单**: 按商家分组浏览，支持**轮播图 (Carousel)** 切换商家。
- [x] **商品详情**: 查看菜品高清图片、价格及实时库存。
- [x] **在线下单**: 购物车管理，一键下单。
- [x] **订单追踪**: 实时查看订单状态（待发货/已发货/已拒单）。

### 🏪 商家端 (Merchant)
- [x] **工作台**: 商家专属管理后台。
- [x] **菜品管理**: 支持菜品的上架、下架、编辑及图片上传。
- [x] **订单处理**: 实时接收新订单，执行发货或拒单操作。
- [x] **库存控制**: 订单处理自动联动库存扣减与回滚。

## 🛠 技术栈

| 领域 | 技术组件 | 版本 | 说明 |
| :--- | :--- | :--- | :--- |
| **后端** | Java JDK | 17 (LTS) | 核心开发语言 |
| | Spring Boot | 3.4.0 | 核心应用框架 |
| | MyBatis-Plus | 3.5.5 | ORM 框架 |
| | MySQL | 8.0 | 关系型数据库 |
| **前端** | HTML5 / CSS3 | - | 页面结构与样式 |
| | jQuery | 3.6.4 | DOM 操作与交互 |
| | FontAwesome | 6.4.0 | 矢量图标库 |
| **安全** | Custom Filter | - | 防御路径遍历 (CVE-2025-41242) |

## 📸 界面展示

> *此处可添加项目运行截图*

| 登录页面 | 顾客点餐 |
| :---: | :---: |
| ![Login](image/login_placeholder.png) | ![User](image/user_placeholder.png) |

| 商家后台 | 订单管理 |
| :---: | :---: |
| ![Merchant](image/merchant_placeholder.png) | ![Order](image/order_placeholder.png) |

## 🚀 快速开始

### 环境要求
- **Java**: JDK 17+
- **Maven**: 3.8+
- **MySQL**: 8.0+

### 安装步骤

1.  **克隆仓库**
    ```bash
    git clone https://github.com/leeepic19/Java-.git
    cd Java-
    ```

2.  **数据库配置**
    - 创建数据库 `food_order_db`。
    - 导入 `init_db.sql` 脚本初始化表结构和数据。
    - 修改 `src/main/resources/application.yml` 中的数据库连接信息：
      ```yaml
      spring:
        datasource:
          url: jdbc:mysql://localhost:3306/food_order_db
          username: your_username
          password: your_password
      ```

3.  **编译与运行**
    ```bash
    cd java-main/food-order-system
    mvn clean package
    java -jar target/food-order-system-0.0.1-SNAPSHOT.jar
    ```

4.  **访问系统**
    - 首页: `http://localhost:8080`
    - 商家端: `http://localhost:8080/merchant.html`

## 📂 项目结构

```text
java-main/food-order-system/
├── src/main/java/com/example/
│   ├── controller/      # API 接口层
│   ├── service/         # 业务逻辑层
│   ├── mapper/          # 数据持久层
│   ├── entity/          # 数据库实体
│   └── config/          # 全局配置
├── src/main/resources/
│   ├── static/          # 前端静态资源 (HTML/CSS/JS)
│   ├── mapper/          # MyBatis XML
│   └── application.yml  # 系统配置
└── pom.xml              # Maven 依赖
```

## 🤝 贡献

欢迎提交 Issue 或 Pull Request 来改进本项目！

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源许可证。
