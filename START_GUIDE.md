# WSDC项目启动指南

## 当前状态
- ✅ 数据库：SQL Server已配置，包含示例数据
- ✅ 前端：Vue 3项目已创建完成
- ⏸️  后端：Spring Boot项目已创建，但无法编译（缺少JDK）

## 问题说明
您的系统只安装了JRE (Java Runtime Environment)，缺少JDK (Java Development Kit)。
Maven需要JDK来编译Java代码。

## 解决方案（选择其一）

### 方案1：安装JDK 8（推荐）

#### 步骤1：下载JDK 8
访问以下任一网站：

**Eclipse Temurin (推荐，免费)**
https://adoptium.net/temurin/releases/?version=8
- 选择：Windows x64
- 文件类型：MSI Installer
- 下载并安装

**Oracle JDK 8**
https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html
- 需要Oracle账号
- 选择：jdk-8u431-windows-x64.exe

#### 步骤2：安装
1. 运行下载的安装程序
2. 安装路径建议：C:\Program Files\Java\jdk1.8.0_xxx
3. 勾选"Set JAVA_HOME variable"（如果有）
4. 完成安装

#### 步骤3：验证
打开新的PowerShell窗口：
```powershell
java -version
javac -version
```

应该看到JDK版本信息。

#### 步骤4：编译并运行
```powershell
cd C:\Users\35278\Desktop\wsdc-master\wsdc-backend
C:\apache-maven-3.9.6\bin\mvn.cmd clean package -DskipTests
java -jar target\wsdc-backend-1.0.0.jar
```

---

### 方案2：使用IDE运行（更简单）

如果您已安装IntelliJ IDEA或Eclipse：

1. 打开IDE
2. 导入Maven项目：`C:\Users\35278\Desktop\wsdc-master\wsdc-backend`
3. IDE会自动下载依赖
4. 右键点击`WsdcApplication.java`
5. 选择"Run"

IDE通常会自动处理JDK配置。

---

### 方案3：使用Docker（最简单，但需要Docker）

如果已安装Docker Desktop：

```powershell
cd C:\Users\35278\Desktop\wsdc-master\wsdc-backend

# 创建Dockerfile
@"
FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests
CMD ["java", "-jar", "target/wsdc-backend-1.0.0.jar"]
"@ | Out-File Dockerfile -Encoding ASCII

# 构建并运行
docker build -t wsdc-backend .
docker run -p 8080:8080 wsdc-backend
```

---

## 启动前端

无论哪种方案，后端启动后，再启动前端：

```powershell
cd C:\Users\35278\Desktop\wsdc-master\wsdc-frontend
npm install
npm run dev
```

前端会运行在：http://localhost:3000
后端API：http://localhost:8080
API文档：http://localhost:8080/doc.html

---

## 快速测试（无需编译后端）

如果只想测试前端界面，可以：

1. 修改前端配置，使用模拟数据
2. 或者等待后端问题解决

---

## 需要帮助？

如果遇到问题，请告诉我您选择了哪个方案，我会提供详细指导。

推荐顺序：
1. 如果有IDE → 方案2
2. 如果有Docker → 方案3  
3. 否则 → 方案1
