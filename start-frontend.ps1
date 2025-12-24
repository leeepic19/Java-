# WSDC前端启动脚本
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "WSDC 前端 - 启动脚本" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "C:\Users\35278\Desktop\wsdc-master\wsdc-frontend"

Write-Host "[1/2] 检查依赖..." -ForegroundColor Yellow
if (-not (Test-Path "node_modules")) {
    Write-Host "首次运行，安装依赖..." -ForegroundColor Yellow
    npm install
} else {
    Write-Host "✓ 依赖已安装" -ForegroundColor Green
}

Write-Host ""
Write-Host "[2/2] 启动开发服务器..." -ForegroundColor Yellow
Write-Host ""
Write-Host "前端地址: http://localhost:3000" -ForegroundColor Green
Write-Host "后端API: http://localhost:8080" -ForegroundColor Green
Write-Host ""
Write-Host "按 Ctrl+C 可停止服务" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

npm run dev
