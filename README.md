# wsdc
基于JavaWeb的网上订餐系统

## 项目介绍
整个项目使用 Servlet + JavaBean + 少量JSTL 完成，属于一个练习Servlet的小项目。

## 技术栈
- **后端**: Java Servlet + JDBC + DBCP2 连接池
- **前端**: JSP + Bootstrap 5 + jQuery
- **数据库**: SQL Server 2022 (支持 MySQL 切换)
- **服务器**: Tomcat 7
- **构建工具**: Maven 3.9.6
- **Java版本**: JDK 11

## 快速启动

### 方式一：一键启动（推荐 - Windows）

1. **配置数据库**
   - 确保 SQL Server 已安装并运行
   - 使用 `wsdc.sql` 导入数据库
   - 如果使用 Windows 身份验证，保持 `src/main/resources/db.properties` 默认配置
   - 如果使用 SQL Server 身份验证，修改配置文件中的用户名和密码

2. **启用 SQL Server TCP/IP**（如果尚未启用）
   ```powershell
   # 以管理员身份运行
   Start-Process powershell -Verb RunAs -ArgumentList "-NoExit", "-File `".\enable-sqlserver-tcp.ps1`""
   ```

3. **一键启动项目**
   ```powershell
   .\setup_and_run.ps1
   ```
   脚本会自动：
   - 检查并下载 Maven 3.9.6
   - 检查并下载 Microsoft JDK 11
   - 下载 SQL Server JDBC 认证 DLL
   - 编译并启动项目

4. **访问应用**
   - 打开浏览器访问: http://localhost:8080

### 方式二：手动启动

1. **环境要求**
   - JDK 11 或更高版本
   - Maven 3.x
   - SQL Server 2016+ 或 MySQL 5.x

2. **数据库配置**
   - 导入 `wsdc.sql` 到数据库
   - 修改 `src/main/resources/db.properties` 配置文件

3. **编译运行**
   ```bash
   mvn clean compile
   mvn tomcat7:run
   ```

4. **访问应用**
   - 浏览器访问: http://localhost:8080

## 数据库配置

### SQL Server（默认）
```properties
driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
url=jdbc:sqlserver://localhost;databaseName=wsdc;encrypt=true;trustServerCertificate=true;integratedSecurity=true
```

### MySQL
取消 `db.properties` 中 MySQL 配置的注释：
```properties
driverClassName=com.mysql.jdbc.Driver
url=jdbc:mysql://localhost:3306/wsdc?useUnicode=true&characterEncoding=UTF-8
username=root
password=123
```

## 项目结构
```
wsdc-master/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── dao/          # 数据访问接口
│   │   │   ├── factory/      # 工厂模式
│   │   │   ├── filter/       # 过滤器
│   │   │   ├── servlet/      # 控制器
│   │   │   ├── util/         # 数据库连接池
│   │   │   └── vo/           # 实体类
│   │   ├── resources/
│   │   │   └── db.properties # 数据库配置
│   │   └── webapp/
│   │       ├── css/          # 样式文件
│   │       ├── js/           # JavaScript
│   │       ├── images/       # 图片资源
│   │       └── *.jsp         # JSP页面
├── setup_and_run.ps1         # 一键启动脚本（Windows）
├── enable-sqlserver-tcp.ps1  # SQL Server TCP/IP启用脚本
├── wsdc.sql                  # 数据库脚本
└── pom.xml                   # Maven配置

```

## 常见问题

### 1. 数据库连接失败
- **SQL Server TCP/IP 未启用**: 运行 `enable-sqlserver-tcp.ps1` 脚本
- **端口错误**: 确认 SQL Server 监听端口（默认1433）
- **认证失败**: 检查 `db.properties` 中的认证方式

### 2. 页面显示乱码
- 确保所有文件编码为 UTF-8
- 检查 `CharacterEncodingFilter` 过滤器配置

### 3. Maven 依赖下载失败
- 检查网络连接
- 配置 Maven 镜像源（如阿里云）

## 更新日志

### 2024-12-24
- ✅ 升级到 SQL Server 2022 支持
- ✅ 添加 Maven 构建支持
- ✅ 集成 Bootstrap 5 前端框架
- ✅ 优化数据库连接池配置（DBCP2）
- ✅ 添加一键启动脚本（Windows PowerShell）
- ✅ 修复文件编码问题（UTF-8）
- ✅ 添加 SQL Server TCP/IP 自动配置脚本

## 运行环境
Tomcat v7.0 + SQL Server 2022 / MySQL 5

## 开发工具
Eclipse / IntelliJ IDEA + Maven + SQL Server Management Studio

## 部分截图
登录界面
![登录](https://raw.githubusercontent.com/sdan8/MarkdownPhoto/master/wsdc_2.jpg)
首页
![首页](https://raw.githubusercontent.com/sdan8/MarkdownPhoto/master/wsdc_0.jpg)
会员管理中心
![会员管理中心](https://raw.githubusercontent.com/sdan8/MarkdownPhoto/master/wsdc_1.jpg)
