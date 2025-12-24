# WSDC 订餐系统 - Spring Boot + Vue 实施方案

## 📋 项目规划

### 1. 技术栈升级

#### 后端 (Spring Boot 3.x)
- **框架**: Spring Boot 3.2.0
- **数据访问**: Spring Data JPA / MyBatis-Plus
- **安全**: Spring Security + JWT
- **API文档**: Swagger/Knife4j
- **缓存**: Redis
- **验证**: Hibernate Validator
- **日志**: Logback + SLF4J

#### 前端 (Vue 3.x)
- **框架**: Vue 3 + TypeScript
- **构建工具**: Vite
- **UI库**: Element Plus / Ant Design Vue
- **状态管理**: Pinia
- **路由**: Vue Router 4
- **HTTP**: Axios
- **工具**: Vue Use

#### 数据库
- **主数据库**: SQL Server 2022
- **缓存**: Redis 7.x

---

## 🏗️ 项目结构

### 后端结构
```
wsdc-backend/
├── src/main/java/com/wsdc/
│   ├── WsdcApplication.java          # 启动类
│   ├── config/                        # 配置类
│   │   ├── SecurityConfig.java       # 安全配置
│   │   ├── RedisConfig.java          # Redis配置
│   │   ├── SwaggerConfig.java        # API文档配置
│   │   └── CorsConfig.java           # 跨域配置
│   ├── controller/                    # 控制器
│   │   ├── AuthController.java       # 认证控制器
│   │   ├── MenuController.java       # 菜品管理
│   │   ├── CartController.java       # 购物车
│   │   ├── OrderController.java      # 订单管理
│   │   └── UserController.java       # 用户管理
│   ├── service/                       # 业务层
│   │   ├── AuthService.java
│   │   ├── MenuService.java
│   │   ├── CartService.java
│   │   ├── OrderService.java
│   │   └── UserService.java
│   ├── repository/                    # 数据访问层
│   │   ├── UserRepository.java
│   │   ├── MenuRepository.java
│   │   ├── OrderRepository.java
│   │   └── CartRepository.java
│   ├── entity/                        # 实体类
│   │   ├── User.java
│   │   ├── Menu.java
│   │   ├── Cart.java
│   │   ├── Order.java
│   │   └── OrderItem.java
│   ├── dto/                           # 数据传输对象
│   │   ├── request/
│   │   │   ├── LoginRequest.java
│   │   │   ├── RegisterRequest.java
│   │   │   └── CartRequest.java
│   │   └── response/
│   │       ├── LoginResponse.java
│   │       └── MenuResponse.java
│   ├── security/                      # 安全相关
│   │   ├── JwtTokenProvider.java     # JWT工具
│   │   ├── UserDetailsServiceImpl.java
│   │   └── JwtAuthenticationFilter.java
│   ├── exception/                     # 异常处理
│   │   ├── GlobalExceptionHandler.java
│   │   └── BusinessException.java
│   └── util/                          # 工具类
│       ├── MD5Utils.java
│       ├── ResultUtil.java
│       └── QRCodeUtil.java
├── src/main/resources/
│   ├── application.yml               # 主配置文件
│   ├── application-dev.yml           # 开发环境
│   └── application-prod.yml          # 生产环境
└── pom.xml
```

### 前端结构
```
wsdc-frontend/
├── src/
│   ├── main.ts                       # 入口文件
│   ├── App.vue                       # 根组件
│   ├── views/                        # 页面组件
│   │   ├── Home.vue                  # 首页/菜品列表
│   │   ├── Login.vue                 # 登录注册
│   │   ├── MenuDetail.vue            # 菜品详情
│   │   ├── Cart.vue                  # 购物车
│   │   ├── Order.vue                 # 订单列表
│   │   ├── Payment.vue               # 支付页面
│   │   ├── Profile.vue               # 个人中心
│   │   └── Admin/                    # 后台管理
│   │       ├── Dashboard.vue
│   │       ├── MenuManage.vue
│   │       ├── OrderManage.vue
│   │       └── UserManage.vue
│   ├── components/                   # 通用组件
│   │   ├── Header.vue
│   │   ├── Footer.vue
│   │   ├── MenuCard.vue
│   │   └── OrderItem.vue
│   ├── router/                       # 路由配置
│   │   └── index.ts
│   ├── stores/                       # 状态管理
│   │   ├── user.ts
│   │   ├── cart.ts
│   │   └── menu.ts
│   ├── api/                          # API接口
│   │   ├── auth.ts
│   │   ├── menu.ts
│   │   ├── cart.ts
│   │   └── order.ts
│   ├── utils/                        # 工具函数
│   │   ├── request.ts                # Axios封装
│   │   ├── auth.ts                   # 认证工具
│   │   └── validate.ts               # 表单验证
│   ├── assets/                       # 静态资源
│   └── styles/                       # 样式文件
├── package.json
├── vite.config.ts
└── tsconfig.json
```

---

## 🚀 快速开始指南

### 步骤1: 创建 Spring Boot 后端

```bash
# 方法1: 使用 Spring Initializr
访问: https://start.spring.io/
配置:
- Project: Maven
- Language: Java
- Spring Boot: 3.2.0
- Group: com.wsdc
- Artifact: wsdc-backend
- Dependencies: 
  * Spring Web
  * Spring Data JPA
  * Spring Security
  * SQL Server Driver
  * Redis
  * Lombok
  * Validation

# 方法2: 使用命令行
curl https://start.spring.io/starter.zip \
  -d dependencies=web,data-jpa,security,sqlserver,data-redis,lombok,validation \
  -d type=maven-project \
  -d javaVersion=17 \
  -d bootVersion=3.2.0 \
  -d groupId=com.wsdc \
  -d artifactId=wsdc-backend \
  -o wsdc-backend.zip

unzip wsdc-backend.zip
```

### 步骤2: 配置 application.yml

```yaml
spring:
  application:
    name: wsdc-backend
  
  datasource:
    url: jdbc:sqlserver://localhost:1433;databaseName=wsdc;encrypt=true;trustServerCertificate=true
    username: sa
    password: your_password
    driver-class-name: com.microsoft.sqlserver.jdbc.SQLServerDriver
    
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        
  redis:
    host: localhost
    port: 6379
    
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 10MB

jwt:
  secret: wsdc-secret-key-2024
  expiration: 86400000  # 24小时

server:
  port: 8080
```

### 步骤3: 创建 Vue 前端

```bash
# 使用 Vite 创建 Vue3 + TypeScript 项目
npm create vite@latest wsdc-frontend -- --template vue-ts

cd wsdc-frontend
npm install

# 安装依赖
npm install vue-router@4 pinia axios
npm install element-plus
npm install @element-plus/icons-vue
npm install pinia-plugin-persistedstate
```

### 步骤4: 配置前端环境变量

```env
# .env.development
VITE_API_BASE_URL=http://localhost:8080/api
VITE_APP_TITLE=WSDC订餐系统

# .env.production
VITE_API_BASE_URL=https://api.wsdc.com/api
VITE_APP_TITLE=WSDC订餐系统
```

---

## 📝 核心功能实现示例

### 1. 后端 - UserController

```java
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService;
    
    @PostMapping("/register")
    public Result<String> register(@Valid @RequestBody RegisterRequest request) {
        authService.register(request);
        return Result.success("注册成功");
    }
    
    @PostMapping("/login")
    public Result<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.login(request);
        return Result.success(response);
    }
    
    @GetMapping("/captcha")
    public void getCaptcha(HttpServletResponse response) throws IOException {
        authService.generateCaptcha(response);
    }
}
```

### 2. 前端 - 登录页面

```vue
<template>
  <div class="login-container">
    <el-card class="login-card">
      <el-tabs v-model="activeTab">
        <el-tab-pane label="登录" name="login">
          <el-form :model="loginForm" :rules="loginRules" ref="loginFormRef">
            <el-form-item prop="username">
              <el-input v-model="loginForm.username" placeholder="用户名">
                <template #prefix><el-icon><User /></el-icon></template>
              </el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="loginForm.password" type="password" placeholder="密码">
                <template #prefix><el-icon><Lock /></el-icon></template>
              </el-input>
            </el-form-item>
            <el-form-item prop="captcha">
              <div class="captcha-wrapper">
                <el-input v-model="loginForm.captcha" placeholder="验证码" />
                <img :src="captchaUrl" @click="refreshCaptcha" class="captcha-img" />
              </div>
            </el-form-item>
            <el-button type="primary" @click="handleLogin" :loading="loading">登录</el-button>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="注册" name="register">
          <!-- 注册表单 -->
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { login } from '@/api/auth'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()
const loginFormRef = ref()
const loading = ref(false)
const captchaUrl = ref('/api/auth/captcha')

const loginForm = reactive({
  username: '',
  password: '',
  captcha: ''
})

const loginRules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  captcha: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
}

const handleLogin = async () => {
  await loginFormRef.value.validate()
  loading.value = true
  try {
    const res = await login(loginForm)
    userStore.setToken(res.data.token)
    userStore.setUserInfo(res.data.user)
    ElMessage.success('登录成功')
    router.push('/')
  } catch (error) {
    ElMessage.error('登录失败')
    refreshCaptcha()
  } finally {
    loading.value = false
  }
}

const refreshCaptcha = () => {
  captchaUrl.value = `/api/auth/captcha?${Date.now()}`
}
</script>
```

---

## 🎯 开发优先级

### 第一阶段 - 基础架构 (1-2天)
- [x] 搭建 Spring Boot 项目
- [x] 搭建 Vue 3 项目
- [x] 配置数据库连接
- [x] 配置 Redis
- [x] 实现 JWT 认证
- [x] 全局异常处理

### 第二阶段 - 用户模块 (2-3天)
- [ ] 用户注册（MD5加密+邮箱验证）
- [ ] 用户登录（JWT+验证码）
- [ ] 个人信息管理
- [ ] 密码修改

### 第三阶段 - 菜品模块 (2-3天)
- [ ] 菜品列表展示（分页+搜索）
- [ ] 菜品详情页
- [ ] 菜品分类
- [ ] 推荐菜品

### 第四阶段 - 购物车模块 (2天)
- [ ] 添加到购物车（Redis存储）
- [ ] 购物车列表
- [ ] 修改数量
- [ ] 删除商品

### 第五阶段 - 订单模块 (3-4天)
- [ ] 创建订单
- [ ] 订单列表
- [ ] 订单详情
- [ ] 支付模拟（二维码）
- [ ] 订单状态管理

### 第六阶段 - 后台管理 (3-4天)
- [ ] 管理员登录
- [ ] 菜品管理（CRUD+图片上传）
- [ ] 订单管理
- [ ] 用户管理
- [ ] 数据统计

---

## 📦 关键依赖版本

### 后端 (pom.xml)
```xml
<properties>
    <java.version>17</java.version>
    <spring-boot.version>3.2.0</spring-boot.version>
    <mybatis-plus.version>3.5.5</mybatis-plus.version>
    <jwt.version>0.11.5</jwt.version>
</properties>

<dependencies>
    <!-- Spring Boot Starter -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    
    <!-- Spring Data JPA -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    
    <!-- Spring Security -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    
    <!-- Redis -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>
    
    <!-- SQL Server -->
    <dependency>
        <groupId>com.microsoft.sqlserver</groupId>
        <artifactId>mssql-jdbc</artifactId>
    </dependency>
    
    <!-- JWT -->
    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt-api</artifactId>
        <version>${jwt.version}</version>
    </dependency>
    
    <!-- Lombok -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
    </dependency>
    
    <!-- Validation -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>
    
    <!-- Swagger -->
    <dependency>
        <groupId>com.github.xiaoymin</groupId>
        <artifactId>knife4j-openapi3-jakarta-spring-boot-starter</artifactId>
        <version>4.3.0</version>
    </dependency>
</dependencies>
```

### 前端 (package.json)
```json
{
  "dependencies": {
    "vue": "^3.3.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0",
    "element-plus": "^2.4.0",
    "@element-plus/icons-vue": "^2.1.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.4.0",
    "typescript": "^5.2.0",
    "vite": "^5.0.0",
    "unplugin-auto-import": "^0.17.0",
    "unplugin-vue-components": "^0.26.0"
  }
}
```

---

## 🔧 开发工具推荐

- **IDE**: IntelliJ IDEA (后端) + VS Code (前端)
- **API测试**: Postman / Apifox
- **数据库工具**: Azure Data Studio
- **Git**: GitHub Desktop / SourceTree
- **Redis**: Redis Desktop Manager

---

## ✅ 下一步行动

您现在可以选择：

### 选项A: 全新 Spring Boot + Vue 项目
我将帮您：
1. 生成完整的 Spring Boot 项目骨架
2. 生成 Vue 3 前端项目
3. 配置数据库和基础架构
4. 实现核心功能模块

### 选项B: 修复当前项目
解决数据库连接池问题，继续使用 JSP + Servlet 架构

**推荐选项A**，因为：
- ✅ 更现代化的技术栈
- ✅ 前后端分离，易于维护
- ✅ 更好的开发体验
- ✅ 更符合企业实际需求
- ✅ 更容易扩展功能

您想选择哪个方案？
