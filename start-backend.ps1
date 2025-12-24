# WSDC项目完整启动脚本
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "WSDC 外卖点餐系统 - 启动脚本" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# 配置Java路径
$JAVA_HOME = "E:\OpenJDK8U-jdk_x64_windows_hotspot_8u472b08\jdk8u472-b08"
$JAVA_EXE = "$JAVA_HOME\bin\java.exe"

Write-Host "[1/3] 检查环境..." -ForegroundColor Yellow

# 检查JDK
if (Test-Path $JAVA_EXE) {
    Write-Host "✓ JDK 8 已就绪" -ForegroundColor Green
    & $JAVA_EXE -version
} else {
    Write-Host "❌ 未找到JDK" -ForegroundColor Red
    exit 1
}

Write-Host ""

# 检查后端JAR
$JAR_FILE = "C:\Users\35278\Desktop\wsdc-master\wsdc-backend\target\wsdc-backend-1.0.0.jar"
if (-not (Test-Path $JAR_FILE)) {
    Write-Host "❌ 后端JAR文件不存在，需要先编译" -ForegroundColor Red
    Write-Host "运行: cd wsdc-backend; C:\apache-maven-3.9.6\bin\mvn.cmd clean package -DskipTests" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ 后端JAR文件已就绪" -ForegroundColor Green

Write-Host ""
Write-Host "[2/3] 测试数据库连接..." -ForegroundColor Yellow

sqlcmd -S localhost -U wsdcuser -P "Wsdc@2024" -d wsdc -Q "SELECT COUNT(*) AS menu_count FROM tb_menu" 2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 数据库连接正常" -ForegroundColor Green
} else {
    Write-Host "❌ 数据库连接失败" -ForegroundColor Red
    Write-Host ""
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 以管理员身份运行PowerShell" -ForegroundColor White
    Write-Host "2. 执行: .\restart-sql-server.ps1" -ForegroundColor White
    Write-Host "3. 然后重新运行此脚本" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "[3/3] 启动服务..." -ForegroundColor Yellow
Write-Host ""

Write-Host "正在启动后端服务..." -ForegroundColor Cyan
Write-Host "后端地址: http://localhost:8080" -ForegroundColor Green
Write-Host "API文档: http://localhost:8080/doc.html" -ForegroundColor Green
Write-Host ""
Write-Host "按 Ctrl+C 可停止服务" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "C:\Users\35278\Desktop\wsdc-master\wsdc-backend"
& $JAVA_EXE -jar $JAR_FILE
