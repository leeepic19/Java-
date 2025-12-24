# 自动下载并安装JDK 17
# 使用winget包管理器（Windows 10/11内置）

Write-Host "====================" -ForegroundColor Cyan
Write-Host "自动安装 Microsoft OpenJDK 17" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""

# 检查winget是否可用
try {
    winget --version | Out-Null
    Write-Host "✓ winget可用" -ForegroundColor Green
} catch {
    Write-Host "❌ winget不可用，请手动下载安装" -ForegroundColor Red
    Write-Host "下载地址: https://learn.microsoft.com/en-us/java/openjdk/download" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "开始安装 Microsoft OpenJDK 17..." -ForegroundColor Yellow
Write-Host "这可能需要几分钟时间..." -ForegroundColor White
Write-Host ""

# 安装Microsoft OpenJDK 17
winget install Microsoft.OpenJDK.17

Write-Host ""
Write-Host "====================" -ForegroundColor Cyan
Write-Host "安装完成！" -ForegroundColor Green
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "重要提示:" -ForegroundColor Yellow
Write-Host "1. 请关闭当前PowerShell窗口" -ForegroundColor White
Write-Host "2. 打开新的PowerShell窗口" -ForegroundColor White
Write-Host "3. 运行: java -version 验证安装" -ForegroundColor White
Write-Host "4. 运行: .\recreate_backend.ps1 重建后端" -ForegroundColor White
Write-Host ""
