# 网上订餐系统 (WSDC) - 运行指南

## 环境准备

### 必需软件
1. **JDK 1.8+** ✅ (已安装)
2. **Maven 3.x** ❌ (未安装)
3. **SQL Server 2022** ✅ (已安装并配置)

---

## 快速开始

### 方法一：安装 Maven 后运行（推荐）

#### 1. 下载并安装 Maven
1. 访问 [Maven 官网](https://maven.apache.org/download.cgi)
2. 下载 `apache-maven-3.9.x-bin.zip`
3. 解压到 `C:\Program Files\Apache\maven`

#### 2. 配置环境变量
在 Windows 中添加以下环境变量：
- **新建系统变量**：
  - 变量名：`MAVEN_HOME`
  - 变量值：`C:\Program Files\Apache\maven`
- **编辑 Path 变量**，添加：
  - `%MAVEN_HOME%\bin`

#### 3. 验证安装
打开**新的** PowerShell 窗口，运行：
```powershell
mvn -version
```

#### 4. 启动项目
双击项目根目录的 `start.bat` 脚本，或在终端运行：
```powershell
mvn tomcat7:run
```

#### 5. 访问网站
浏览器打开：[http://localhost:8080/wsdc](http://localhost:8080/wsdc)

---

### 方法二：使用 VS Code + SQL Server 扩展（开发调试）

#### 1. 配置 SQL Server 连接
我已经为你创建了 `.vscode/settings.json`，配置了本地 SQL Server 连接。

在 VS Code 中：
1. 点击左侧边栏的 **SQL Server** 图标
2. 应该能看到 "WSDC Local" 连接
3. 展开可以查看所有数据表

#### 2. 查看和编辑数据
- 右键点击表名 → "Select Top 1000" 查看数据
- 可以直接执行 SQL 查询

---

### 方法三：导入到 Eclipse/IntelliJ IDEA

如果你有 Eclipse 或 IntelliJ IDEA：

1. 选择 `File` -> `Import` -> `Existing Maven Projects`
2. 选择项目根目录 `wsdc-master`
3. 配置 Tomcat 服务器
4. 右键项目 -> `Run As` -> `Run on Server`

---

## 数据库连接配置

### 当前配置（Windows 集成验证）
文件：`src/main/resources/db.properties`

```properties
driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
url=jdbc:sqlserver://localhost;databaseName=wsdc;encrypt=false;trustServerCertificate=true;integratedSecurity=true
```

### 如果需要使用账号密码登录
修改 `db.properties`：
```properties
driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
url=jdbc:sqlserver://localhost;databaseName=wsdc;encrypt=false;trustServerCertificate=true
username=sa
password=你的密码
```

---

## 常见问题

### 1. Maven 命令找不到
**原因**：Maven 未安装或环境变量未配置。
**解决**：按照"方法一"完成 Maven 安装和环境变量配置，**重启终端**。

### 2. 数据库连接失败
**原因**：SQL Server 服务未启动或集成验证失败。
**解决**：
- 检查 SQL Server 服务是否运行（服务名：`MSSQLSERVER`）
- 尝试改用账号密码登录（参考上方配置）

### 3. 端口 8080 被占用
**解决**：修改 `pom.xml` 中的端口号：
```xml
<configuration>
  <port>8081</port>  <!-- 改为其他端口 -->
</configuration>
```

---

## 默认账号

### 管理员账号
- 用户名：`admin`
- 密码：`admin`

（在数据库初始化时已自动创建）

---

## 项目结构说明

```
wsdc-master/
├── pom.xml                    # Maven 配置文件
├── start.bat                  # Windows 启动脚本
├── wsdc_mssql.sql             # SQL Server 数据库脚本
├── PROJECT_INTRO.md           # 项目需求文档
├── src/
│   ├── main/
│   │   ├── java/              # Java 源代码
│   │   │   ├── dao/           # 数据访问层
│   │   │   ├── servlet/       # Servlet 控制器
│   │   │   ├── util/          # 工具类（数据库连接池）
│   │   │   └── vo/            # 实体类
│   │   ├── resources/         # 配置文件
│   │   │   └── db.properties  # 数据库配置
│   │   └── webapp/            # Web 资源
│   │       ├── WEB-INF/
│   │       ├── *.jsp          # JSP 页面
│   │       ├── css/
│   │       ├── js/
│   │       └── images/
└── .vscode/
    └── settings.json          # VS Code SQL Server 连接配置
```

---

祝开发顺利！如有问题请参考 `PROJECT_INTRO.md` 或联系团队成员。
