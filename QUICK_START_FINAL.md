# WSDC完整项目启动指南

## 当前状态
✅ JDK 8 已配置（E:\OpenJDK8U-jdk_x64_windows_hotspot_8u472b08\jdk8u472-b08）
✅ Maven 3.9.6 已安装（C:\apache-maven-3.9.6）
✅ 后端项目已编译成功
✅ 前端项目已创建完成
✅ 数据库用户已创建（wsdcuser/Wsdc@2024）
⏸️  需要重启SQL Server服务以启用混合认证模式

---

## 快速启动（3个步骤）

### 步骤1：重启SQL Server服务

**以管理员身份打开PowerShell**，然后运行：

```powershell
cd C:\Users\35278\Desktop\wsdc-master
.\restart-sql-server.ps1
```

这将重启SQL Server并启用混合认证模式。

---

### 步骤2：启动后端服务

在**普通PowerShell窗口**中运行：

```powershell
cd C:\Users\35278\Desktop\wsdc-master
.\start-backend.ps1
```

等待看到：
```
Started WsdcApplication in X.XXX seconds
```

后端服务地址：
- **API**: http://localhost:8080
- **文档**: http://localhost:8080/doc.html

---

### 步骤3：启动前端服务

打开**新的PowerShell窗口**，运行：

```powershell
cd C:\Users\35278\Desktop\wsdc-master
.\start-frontend.ps1
```

前端地址：http://localhost:3000

---

## 访问系统

浏览器打开：**http://localhost:3000**

### 默认账号
- 可以注册新账号
- 或使用数据库中现有账号（如有）

---

## 故障排除

### 问题1：后端无法连接数据库
**错误**: 用户 'wsdcuser' 登录失败

**解决**:
```powershell
# 以管理员身份运行
.\restart-sql-server.ps1
```

### 问题2：端口被占用
**错误**: Port 8080 is already in use

**解决**:
```powershell
# 查找占用进程
netstat -ano | findstr :8080
# 结束进程（PID是上一步最后一列的数字）
taskkill /F /PID <PID>
```

### 问题3：前端无法连接后端
**检查**:
- 后端是否正常运行（访问 http://localhost:8080）
- 查看浏览器控制台错误信息

---

## 开发说明

### 后端技术栈
- Spring Boot 2.5.15
- Spring Data JPA
- Spring Security
- SQL Server 2022
- Knife4j (API文档)

### 前端技术栈
- Vue 3.4.0
- TypeScript
- Element Plus
- Pinia (状态管理)
- Vue Router
- Axios

### API文档
后端启动后访问：http://localhost:8080/doc.html

---

## 下次快速启动

创建桌面快捷方式或使用以下命令：

```powershell
# 后端（窗口1）
C:\Users\35278\Desktop\wsdc-master\start-backend.ps1

# 前端（窗口2）
C:\Users\35278\Desktop\wsdc-master\start-frontend.ps1
```

---

## 数据库信息

- **服务器**: localhost:1433
- **数据库**: wsdc
- **用户名**: wsdcuser
- **密码**: Wsdc@2024

---

## 项目结构

```
wsdc-master/
├── wsdc-backend/          # Spring Boot后端
│   ├── src/
│   ├── target/
│   └── pom.xml
├── wsdc-frontend/         # Vue 3前端
│   ├── src/
│   ├── package.json
│   └── vite.config.ts
├── start-backend.ps1      # 后端启动脚本
├── start-frontend.ps1     # 前端启动脚本
└── restart-sql-server.ps1 # SQL Server重启脚本
```

---

**祝使用愉快！** 🎉
