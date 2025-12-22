@echo off
echo ================================================
echo   网上订餐系统 (WSDC) 启动脚本
echo ================================================
echo.
echo 检测环境...
echo.

REM 检查 Maven 是否安装
where mvn >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Maven！
    echo.
    echo 请按照以下步骤安装 Maven:
    echo 1. 访问 https://maven.apache.org/download.cgi
    echo 2. 下载 apache-maven-3.x.x-bin.zip
    echo 3. 解压到 C:\Program Files\Apache\maven
    echo 4. 添加环境变量:
    echo    - MAVEN_HOME = C:\Program Files\Apache\maven
    echo    - Path 中添加 %%MAVEN_HOME%%\bin
    echo 5. 重新打开命令行窗口并运行此脚本
    echo.
    pause
    exit /b 1
)

echo [成功] Maven 已安装
mvn -version
echo.

REM 检查 Java 是否安装
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Java！
    echo 请先安装 JDK 1.8 或更高版本
    pause
    exit /b 1
)

echo [成功] Java 已安装
java -version
echo.

REM 检查 SQL Server 数据库
echo 检查 SQL Server 数据库...
sqlcmd -S localhost -E -Q "SELECT name FROM sys.databases WHERE name='wsdc'" >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 无法连接到 SQL Server 或数据库 wsdc 不存在
    echo 请确保:
    echo 1. SQL Server 服务已启动
    echo 2. 已执行过 wsdc_mssql.sql 脚本创建数据库
    echo.
)

echo.
echo ================================================
echo   开始启动 Tomcat 服务器...
echo ================================================
echo.
echo 项目将运行在: http://localhost:8080/wsdc
echo 按 Ctrl+C 停止服务器
echo.

mvn clean tomcat7:run

pause
