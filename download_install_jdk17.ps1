# 手动下载并安装 JDK 17

$downloadUrl = "https://aka.ms/download-jdk/microsoft-jdk-17.0.13-windows-x64.msi"
$installerPath = "$env:TEMP\microsoft-jdk-17.msi"

Write-Host "====================" -ForegroundColor Cyan
Write-Host "下载 Microsoft OpenJDK 17" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""

try {
    Write-Host "正在下载 JDK 17..." -ForegroundColor Yellow
    Write-Host "URL: $downloadUrl" -ForegroundColor White
    Write-Host ""
    
    # 使用.NET WebClient下载
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($downloadUrl, $installerPath)
    
    Write-Host "✓ 下载完成！" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "正在安装 JDK 17..." -ForegroundColor Yellow
    Write-Host "请在安装向导中点击'下一步'完成安装" -ForegroundColor White
    Write-Host ""
    
    # 静默安装（需要管理员权限）
    Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /passive ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome" -Wait
    
    Write-Host "✓ 安装完成！" -ForegroundColor Green
    Write-Host ""
    
    # 清理安装文件
    Remove-Item $installerPath -Force
    
    Write-Host "====================" -ForegroundColor Cyan
    Write-Host "安装成功！" -ForegroundColor Green
    Write-Host "====================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "重要提示:" -ForegroundColor Yellow
    Write-Host "1. 请关闭当前PowerShell窗口" -ForegroundColor White
    Write-Host "2. 打开新的PowerShell窗口" -ForegroundColor White
    Write-Host "3. 验证安装: java -version" -ForegroundColor White
    Write-Host ""
    
} catch {
    Write-Host "❌ 错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "请手动下载并安装:" -ForegroundColor Yellow
    Write-Host "https://learn.microsoft.com/en-us/java/openjdk/download" -ForegroundColor Cyan
}
