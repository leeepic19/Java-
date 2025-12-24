# 🍜 外卖点餐系统 - 快速启动指南

## ✅ 项目已完成创建

恭喜！基于 **Spring Boot 3.2.0 + Vue 3** 的现代化外卖点餐系统已成功创建。

## 📁 项目结构

```
wsdc-master/
├── wsdc-backend/          ✅ Spring Boot 3.2.0 后端 (已完成)
│   ├── pom.xml           - Maven配置
│   ├── application.yml   - 应用配置
│   └── src/main/java/com/wsdc/
│       ├── WsdcApplication.java    - 主启动类
│       ├── entity/                 - 4个实体类 (User, Menu, Order, OrderItem)
│       ├── repository/             - 4个Repository接口
│       ├── service/                - 3个Service (Auth, Menu, Order)
│       ├── controller/             - 3个Controller (REST API)
│       ├── dto/                    - 6个DTO类
│       ├── config/                 - 安全配置、Swagger配置
│       ├── filter/                 - JWT过滤器
│       ├── util/                   - JWT、MD5工具类
│       └── exception/              - 全局异常处理
│
└── wsdc-frontend/         ✅ Vue 3 + TypeScript 前端 (已完成)
    ├── package.json       - NPM配置
    ├── vite.config.ts     - Vite配置
    └── src/
        ├── main.ts        - 入口文件
        ├── App.vue        - 根组件
        ├── api/           - 3个API模块 (auth, menu, order)
        ├── views/         - 6个页面组件
        ├── layout/        - 布局组件
        ├── stores/        - Pinia状态管理 (user, cart)
        ├── router/        - 路由配置
        └── utils/         - Axios请求封装
```

## 🎯 已实现功能

### 后端 API (共15+个接口)

#### 1. 认证模块 (`/api/auth/`)
- ✅ POST `/login` - 用户登录 (JWT Token)
- ✅ POST `/register` - 用户注册
- ✅ GET `/current` - 获取当前用户信息

#### 2. 菜单模块 (`/api/menu/`)
- ✅ GET `/list` - 获取所有菜品
- ✅ GET `/recommended` - 获取推荐菜品
- ✅ GET `/category/{category}` - 按分类获取
- ✅ GET `/search?keyword=` - 搜索菜品
- ✅ GET `/{menuId}` - 获取菜品详情

#### 3. 订单模块 (`/api/order/`)
- ✅ POST `/create` - 创建订单
- ✅ POST `/{orderId}/pay` - 支付订单
- ✅ GET `/my` - 获取我的订单列表
- ✅ GET `/{orderId}` - 获取订单详情

### 前端页面 (共6个页面)

- ✅ **登录页面** - 用户登录
- ✅ **注册页面** - 用户注册
- ✅ **首页** - 推荐菜品展示 + 轮播图
- ✅ **菜单页面** - 菜品列表、分类、搜索
- ✅ **购物车页面** - 购物车管理、下单
- ✅ **订单页面** - 订单列表、详情、支付
- ✅ **个人中心** - 用户信息展示

### 技术特性

#### 后端技术
- ✅ Spring Boot 3.2.0
- ✅ Spring Security + JWT认证
- ✅ Spring Data JPA (Hibernate)
- ✅ 统一响应格式 (Result类)
- ✅ 全局异常处理
- ✅ 参数校验 (Validation)
- ✅ Knife4j API文档
- ✅ CORS跨域支持
- ✅ MD5密码加密

#### 前端技术
- ✅ Vue 3 Composition API
- ✅ TypeScript
- ✅ Element Plus UI
- ✅ Pinia 状态管理
- ✅ Vue Router 路由
- ✅ Axios 请求拦截
- ✅ JWT Token 管理
- ✅ 响应式设计

## 🚀 启动步骤

### 方式1: 使用启动脚本 (推荐)

```powershell
cd C:\Users\35278\Desktop\wsdc-master
.\start.ps1
```

脚本会自动：
1. ✅ 检查 Java、Node.js、SQL Server 环境
2. ✅ 编译并启动后端 (端口 8080)
3. ✅ 安装依赖并启动前端 (端口 3000)

### 方式2: 手动启动

#### 1️⃣ 启动后端

```powershell
cd wsdc-backend
mvn clean install
mvn spring-boot:run
```

后端启动后访问：
- 应用: http://localhost:8080/api
- API文档: http://localhost:8080/api/doc.html

#### 2️⃣ 启动前端

```powershell
cd wsdc-frontend
npm install
npm run dev
```

前端启动后访问: http://localhost:3000

## 📝 配置检查

### 数据库配置

确保 [application.yml](wsdc-backend/src/main/resources/application.yml) 中的数据库连接正确：

```yaml
spring:
  datasource:
    url: jdbc:sqlserver://localhost;databaseName=wsdc;integratedSecurity=true
```

### 数据初始化

数据库已有数据：
- ✅ 8个菜品 (宫保鸡丁、红烧肉、清蒸鲈鱼等)
- ✅ 3个推荐菜品
- ✅ 1条介绍信息

如需重新初始化，执行：
```powershell
sqlcmd -S localhost -E -d wsdc -i wsdc.sql
```

## 🧪 测试流程

### 1. 注册新用户
访问 http://localhost:3000/register

### 2. 登录系统
使用注册的账号登录

### 3. 浏览菜品
- 首页查看推荐菜品
- 菜单页面浏览所有菜品、搜索

### 4. 加入购物车
点击"加入购物车"按钮

### 5. 下单支付
- 进入购物车页面
- 填写配送地址和电话
- 提交订单
- 选择支付方式完成支付

### 6. 查看订单
在"我的订单"页面查看订单状态

## 📚 API文档

启动后端后，访问 Swagger UI:
- **URL**: http://localhost:8080/api/doc.html
- **用户名**: 无需认证（部分接口需要JWT Token）

## 🔑 JWT认证

前端会自动在请求头中携带Token:
```
Authorization: Bearer <your-jwt-token>
```

Token有效期: 24小时

## 🛠️ 开发工具推荐

- **后端IDE**: IntelliJ IDEA / Eclipse
- **前端IDE**: VS Code (已在使用)
- **数据库**: SQL Server Management Studio
- **API测试**: Postman / Apifox
- **版本控制**: Git

## 📊 数据库表结构

- `tb_user` - 用户表
- `tb_menu` - 菜品表
- `tb_orders` - 订单表
- `tb_order_item` - 订单明细表 (新增)
- `tb_menu_top` - 推荐菜品表
- `tb_introduce` - 介绍信息表
- `tb_message` - 留言表 (未使用)

## 🎨 前端页面路由

```
/login          - 登录
/register       - 注册
/               - 主布局
  ├── /home     - 首页
  ├── /menu     - 菜单
  ├── /cart     - 购物车 (需登录)
  ├── /order    - 订单 (需登录)
  └── /profile  - 个人中心 (需登录)
```

## ⚠️ 常见问题

### Q: 后端启动失败？
A: 检查：
1. JDK版本是否为17+
2. SQL Server是否启动
3. 数据库连接配置是否正确
4. 端口8080是否被占用

### Q: 前端无法连接后端？
A: 检查：
1. 后端是否启动成功
2. 端口配置是否正确 (后端8080, 前端3000)
3. CORS配置是否正确

### Q: 登录后Token失效？
A: Token有效期24小时，过期后需要重新登录

### Q: 支付功能是真实支付吗？
A: 不是，这是模拟支付，仅更新订单状态

## 🚧 后续开发建议

### 管理员功能
- [ ] 管理员登录
- [ ] 菜品管理 (增删改查)
- [ ] 订单管理
- [ ] 用户管理
- [ ] 数据统计

### 功能增强
- [ ] Redis缓存购物车
- [ ] WebSocket实时订单推送
- [ ] 图片上传
- [ ] 优惠券系统
- [ ] 用户评价
- [ ] 骑手配送管理

### 优化改进
- [ ] 分页查询
- [ ] 数据导出
- [ ] 日志记录
- [ ] 单元测试
- [ ] 性能优化

## 📄 相关文档

- [Spring Boot 官方文档](https://spring.io/projects/spring-boot)
- [Vue 3 官方文档](https://cn.vuejs.org/)
- [Element Plus 官方文档](https://element-plus.org/zh-CN/)
- [原项目规划文档](SPRINGBOOT_VUE_PLAN.md)

## 🎉 总结

✅ **后端**: 29个文件已创建
✅ **前端**: 17个文件已创建
✅ **配置**: 完整的Maven、NPM、Vite配置
✅ **文档**: 启动脚本、README文档

**项目已100%完成基础功能开发！**

现在可以：
1. 运行 `start.ps1` 启动系统
2. 访问 http://localhost:3000 体验
3. 根据需求继续开发管理员功能

祝开发愉快！🎊
