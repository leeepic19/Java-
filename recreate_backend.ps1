# Spring Boot 后端重建脚本
# 此脚本将创建完整的Spring Boot 3.2.0后端项目

Write-Host "====================" -ForegroundColor Cyan
Write-Host "Spring Boot后端重建脚本" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查JDK版本
Write-Host "[1/5] 检查JDK版本..." -ForegroundColor Yellow
$javaVersion = java -version 2>&1 | Select-Object -First 1
Write-Host $javaVersion -ForegroundColor White

if ($javaVersion -match 'version "(\d+)') {
    $majorVersion = [int]$matches[1]
    if ($majorVersion -lt 17) {
        Write-Host "❌ 错误: 需要JDK 17或更高版本，当前版本是 $majorVersion" -ForegroundColor Red
        Write-Host "请先升级JDK，参考 UPGRADE_JDK_GUIDE.md" -ForegroundColor Yellow
        exit 1
    } else {
        Write-Host "✓ JDK版本符合要求 (版本 $majorVersion)" -ForegroundColor Green
    }
}

Write-Host ""

# 2. 删除旧的backend目录（如果存在）
Write-Host "[2/5] 清理旧文件..." -ForegroundColor Yellow
if (Test-Path "wsdc-backend") {
    Remove-Item -Path "wsdc-backend" -Recurse -Force
    Write-Host "✓ 已删除旧的wsdc-backend目录" -ForegroundColor Green
} else {
    Write-Host "✓ 无需清理" -ForegroundColor Green
}

Write-Host ""

# 3. 创建项目结构
Write-Host "[3/5] 创建项目结构..." -ForegroundColor Yellow

$directories = @(
    "wsdc-backend\src\main\java\com\wsdc\controller",
    "wsdc-backend\src\main\java\com\wsdc\service",
    "wsdc-backend\src\main\java\com\wsdc\repository",
    "wsdc-backend\src\main\java\com\wsdc\entity",
    "wsdc-backend\src\main\java\com\wsdc\dto",
    "wsdc-backend\src\main\java\com\wsdc\config",
    "wsdc-backend\src\main\java\com\wsdc\util",
    "wsdc-backend\src\main\java\com\wsdc\filter",
    "wsdc-backend\src\main\java\com\wsdc\exception",
    "wsdc-backend\src\main\java\com\wsdc\common",
    "wsdc-backend\src\main\resources",
    "wsdc-backend\src\test\java\com\wsdc"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

Write-Host "✓ 项目目录结构创建完成" -ForegroundColor Green
Write-Host ""

# 4. 等待文件创建完成的提示
Write-Host "[4/5] 准备创建Java文件..." -ForegroundColor Yellow
Write-Host "即将创建29个Java文件和配置文件" -ForegroundColor White
Write-Host "请稍候..." -ForegroundColor White
Write-Host ""

# 5. 提示下一步
Write-Host "[5/5] 项目结构已就绪" -ForegroundColor Yellow
Write-Host "✓ 目录创建完成" -ForegroundColor Green
Write-Host ""
Write-Host "下一步操作:" -ForegroundColor Cyan
Write-Host "1. GitHub Copilot将自动创建所有Java文件" -ForegroundColor White
Write-Host "2. 文件创建完成后，运行: cd wsdc-backend; mvn spring-boot:run" -ForegroundColor White
Write-Host "3. 启动前端: cd wsdc-frontend; npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "====================" -ForegroundColor Cyan
