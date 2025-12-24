# 下载并安装Maven 3.9.6
Write-Host "====================" -ForegroundColor Cyan
Write-Host "Maven 3.9.6 下载安装" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""

$mavenVersion = "3.9.6"
$mavenUrl = "https://dlcdn.apache.org/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$downloadPath = "$env:TEMP\apache-maven-$mavenVersion.zip"
$installPath = "C:\apache-maven-$mavenVersion"

# 检查是否已安装
if (Test-Path $installPath) {
    Write-Host "Maven已安装在: $installPath" -ForegroundColor Green
    $response = Read-Host "是否重新安装? (y/N)"
    if ($response -ne 'y' -and $response -ne 'Y') {
        Write-Host "跳过安装" -ForegroundColor Yellow
        Write-Host "Maven路径: $installPath\bin" -ForegroundColor Cyan
        exit 0
    }
    Remove-Item -Path $installPath -Recurse -Force
}

Write-Host "[1/4] 下载Maven..." -ForegroundColor Yellow
Write-Host "URL: $mavenUrl" -ForegroundColor White
try {
    Invoke-WebRequest -Uri $mavenUrl -OutFile $downloadPath -UseBasicParsing
    Write-Host "✓ 下载完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 下载失败: $_" -ForegroundColor Red
    Write-Host "请手动下载: $mavenUrl" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "[2/4] 解压文件..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $downloadPath -DestinationPath "C:\" -Force
    Write-Host "✓ 解压完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 解压失败: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[3/4] 配置环境变量..." -ForegroundColor Yellow
try {
    # 设置MAVEN_HOME
    [Environment]::SetEnvironmentVariable("MAVEN_HOME", $installPath, "User")
    
    # 添加到PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$installPath\bin*") {
        $newPath = "$currentPath;$installPath\bin"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    }
    
    Write-Host "✓ 环境变量配置完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 配置失败: $_" -ForegroundColor Red
    Write-Host "请手动添加到PATH: $installPath\bin" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[4/4] 验证安装..." -ForegroundColor Yellow
$env:Path = "$env:Path;$installPath\bin"
& "$installPath\bin\mvn.cmd" -version

Write-Host ""
Write-Host "====================" -ForegroundColor Cyan
Write-Host "✓ Maven安装完成！" -ForegroundColor Green
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Important: Please restart PowerShell to use Maven" -ForegroundColor Yellow
Write-Host "Then run: mvn -version" -ForegroundColor White
Write-Host "Then run: .\wsdc-backend\run.bat" -ForegroundColor White
Write-Host ""

# 清理
Remove-Item -Path $downloadPath -Force -ErrorAction SilentlyContinue
