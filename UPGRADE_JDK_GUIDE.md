# JDK 升级指南

## 当前状态
- 当前JDK版本：11.0.29
- 目标JDK版本：17+ (推荐使用17 LTS或21 LTS)

## 方法一：使用Microsoft OpenJDK 17 (推荐)

### 1. 下载JDK 17
访问官方网站下载：
https://learn.microsoft.com/en-us/java/openjdk/download

选择：
- **版本**: OpenJDK 17 LTS
- **操作系统**: Windows
- **架构**: x64
- **文件类型**: MSI Installer

### 2. 安装步骤
1. 运行下载的MSI安装程序
2. 选择安装路径（建议使用默认路径）
3. **重要**：勾选"Add to PATH"选项
4. 完成安装

### 3. 验证安装
打开新的PowerShell窗口，运行：
```powershell
java -version
```

应该看到类似输出：
```
openjdk version "17.0.x"
```

## 方法二：使用Oracle JDK 17

### 1. 下载JDK 17
访问：https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

下载：Windows x64 Installer

### 2. 安装并配置环境变量
1. 运行安装程序
2. 记住安装路径，例如：`C:\Program Files\Java\jdk-17`
3. 设置环境变量（如果安装程序没有自动设置）：
   - 系统变量 `JAVA_HOME` = `C:\Program Files\Java\jdk-17`
   - 将 `%JAVA_HOME%\bin` 添加到 PATH

### 3. 验证安装
```powershell
java -version
mvn -version
```

## 安装完成后的操作

运行自动化脚本重新创建Spring Boot后端：
```powershell
.\recreate_backend.ps1
```

此脚本将：
1. 验证JDK 17+
2. 创建完整的Spring Boot 3.2.0后端项目
3. 配置所有必要的文件
4. 编译并启动后端服务

## 常见问题

### Q: 如何在多个JDK版本之间切换？
A: 修改环境变量JAVA_HOME指向不同的JDK安装路径

### Q: Maven还在使用旧版本JDK？
A: 关闭所有PowerShell窗口，重新打开新窗口

### Q: 安装后仍显示JDK 11？
A: 检查PATH变量顺序，确保新JDK的bin目录在前面
