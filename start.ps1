# 启动外卖点餐系统

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  外卖点餐系统启动脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查JDK
Write-Host "检查 Java 环境..." -ForegroundColor Yellow
$javaVersion = java -version 2>&1 | Select-String "version"
if ($javaVersion) {
    Write-Host "✓ Java 已安装: $javaVersion" -ForegroundColor Green
} else {
    Write-Host "✗ 未检测到 Java，请先安装 JDK 17+" -ForegroundColor Red
    exit 1
}

# 检查Node.js
Write-Host "检查 Node.js 环境..." -ForegroundColor Yellow
$nodeVersion = node -v 2>&1
if ($nodeVersion) {
    Write-Host "✓ Node.js 已安装: $nodeVersion" -ForegroundColor Green
} else {
    Write-Host "✗ 未检测到 Node.js，请先安装 Node.js 16+" -ForegroundColor Red
    exit 1
}

# 检查SQL Server
Write-Host "检查 SQL Server 连接..." -ForegroundColor Yellow
$sqlCheck = sqlcmd -S localhost -E -Q "SELECT @@VERSION" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ SQL Server 连接正常" -ForegroundColor Green
} else {
    Write-Host "✗ 无法连接到 SQL Server" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  启动后端服务 (Spring Boot)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

cd wsdc-backend

# 检查是否已编译
if (-not (Test-Path "target")) {
    Write-Host "首次运行，正在编译后端..." -ForegroundColor Yellow
    mvn clean install -DskipTests
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ 后端编译失败" -ForegroundColor Red
        cd ..
        exit 1
    }
}

Write-Host "启动 Spring Boot 应用..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; mvn spring-boot:run"

Write-Host "✓ 后端服务启动中 (http://localhost:8080)" -ForegroundColor Green
Write-Host "  API文档地址: http://localhost:8080/doc.html" -ForegroundColor Cyan

# 等待后端启动
Write-Host ""
Write-Host "等待后端服务启动 (20秒)..." -ForegroundColor Yellow
Start-Sleep -Seconds 20

# 返回项目根目录
cd ..

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  启动前端服务 (Vue 3)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

cd wsdc-frontend

# 检查是否已安装依赖
if (-not (Test-Path "node_modules")) {
    Write-Host "首次运行，正在安装前端依赖..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ 前端依赖安装失败" -ForegroundColor Red
        exit 1
    }
}

Write-Host "启动 Vite 开发服务器..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; npm run dev"

Write-Host "✓ 前端服务启动中 (http://localhost:3000)" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  系统启动完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "前端地址: http://localhost:3000" -ForegroundColor Cyan
Write-Host "后端地址: http://localhost:8080" -ForegroundColor Cyan
Write-Host "API文档:  http://localhost:8080/api/doc.html" -ForegroundColor Cyan
Write-Host ""
Write-Host "按任意键退出此脚本 (服务将继续在后台运行)..." -ForegroundColor Yellow

# 等待用户按键
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

cd ..
