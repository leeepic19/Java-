# 外卖点餐系统 (WSDC)

基于 **Spring Boot 3.2.0** + **Vue 3** + **Element Plus** 的现代化外卖点餐系统。

## 技术栈

### 后端
- Spring Boot 3.2.0
- Spring Security + JWT
- Spring Data JPA
- SQL Server 2022
- Redis (缓存)
- Knife4j (API文档)

### 前端
- Vue 3
- TypeScript
- Element Plus
- Pinia (状态管理)
- Axios
- Vite

## 项目结构

```
wsdc-master/
├── wsdc-backend/          # Spring Boot 后端
│   ├── src/
│   │   └── main/
│   │       ├── java/com/wsdc/
│   │       │   ├── entity/          # 实体类
│   │       │   ├── repository/      # 数据访问层
│   │       │   ├── service/         # 业务逻辑层
│   │       │   ├── controller/      # 控制器
│   │       │   ├── dto/             # 数据传输对象
│   │       │   ├── config/          # 配置类
│   │       │   ├── filter/          # 过滤器
│   │       │   ├── util/            # 工具类
│   │       │   └── WsdcApplication.java
│   │       └── resources/
│   │           └── application.yml
│   └── pom.xml
│
├── wsdc-frontend/         # Vue 3 前端
│   ├── src/
│   │   ├── api/              # API接口
│   │   ├── views/            # 页面组件
│   │   ├── layout/           # 布局组件
│   │   ├── stores/           # Pinia状态管理
│   │   ├── router/           # 路由配置
│   │   ├── utils/            # 工具函数
│   │   ├── App.vue
│   │   └── main.ts
│   ├── index.html
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── package.json
│
└── wsdc.sql              # 数据库脚本
```

## 功能特性

### 用户功能
- ✅ 用户注册/登录 (JWT认证)
- ✅ 菜单浏览 (分类、搜索、推荐)
- ✅ 购物车管理
- ✅ 在线下单
- ✅ 订单支付
- ✅ 订单查询
- ✅ 个人信息管理

### 系统特性
- JWT Token 身份认证
- 统一异常处理
- 参数校验
- CORS跨域支持
- Swagger API文档
- 响应式前端设计

## 环境要求

- JDK 17+
- Node.js 16+
- Maven 3.6+
- SQL Server 2022
- Redis (可选)

## 快速开始

### 1. 数据库配置

执行 `wsdc.sql` 创建数据库和表结构:

```powershell
sqlcmd -S localhost -E -i wsdc.sql
```

### 2. 启动后端

```powershell
cd wsdc-backend
mvn clean install
mvn spring-boot:run
```

后端服务将在 http://localhost:8080 启动

API文档访问: http://localhost:8080/api/doc.html

### 3. 启动前端

```powershell
cd wsdc-frontend
npm install
npm run dev
```

前端应用将在 http://localhost:3000 启动

## API接口

### 认证接口
- POST `/api/auth/login` - 用户登录
- POST `/api/auth/register` - 用户注册
- GET `/api/auth/current` - 获取当前用户信息

### 菜单接口
- GET `/api/menu/list` - 获取所有菜品
- GET `/api/menu/recommended` - 获取推荐菜品
- GET `/api/menu/category/{category}` - 按分类获取菜品
- GET `/api/menu/search?keyword=` - 搜索菜品
- GET `/api/menu/{menuId}` - 获取菜品详情

### 订单接口
- POST `/api/order/create` - 创建订单
- POST `/api/order/{orderId}/pay` - 支付订单
- GET `/api/order/my` - 获取我的订单
- GET `/api/order/{orderId}` - 获取订单详情

## 配置说明

### 后端配置 (application.yml)

```yaml
spring:
  datasource:
    url: jdbc:sqlserver://localhost;databaseName=wsdc;integratedSecurity=true
    driver-class-name: com.microsoft.sqlserver.jdbc.SQLServerDriver

jwt:
  secret: your-secret-key
  expiration: 86400000  # 24小时
```

### 前端配置 (vite.config.ts)

```typescript
server: {
  port: 3000,
  proxy: {
    '/api': {
      target: 'http://localhost:8080',
      changeOrigin: true
    }
  }
}
```

## 默认账号

系统默认没有预置账号，请先注册新用户。

## 项目截图

(待添加截图)

## 开发计划

- [ ] 管理员后台
- [ ] 订单实时状态推送
- [ ] 优惠券系统
- [ ] 用户评价功能
- [ ] 数据统计报表

## 许可证

MIT License

## 联系方式

如有问题，请提交 Issue 或 Pull Request。
