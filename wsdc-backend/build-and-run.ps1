# 查找Maven
Write-Host "查找Maven..." -ForegroundColor Yellow

$mavenLocations = @(
    "C:\apache-maven*\bin\mvn.cmd",
    "C:\Program Files\apache-maven*\bin\mvn.cmd",
    "C:\Program Files (x86)\apache-maven*\bin\mvn.cmd",
    "$env:USERPROFILE\apache-maven*\bin\mvn.cmd",
    "$env:USERPROFILE\Desktop\apache-maven*\bin\mvn.cmd"
)

$mvnCmd = $null
foreach ($location in $mavenLocations) {
    $found = Get-Item $location -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        $mvnCmd = $found.FullName
        break
    }
}

if (-not $mvnCmd) {
    Write-Host "❌ 未找到Maven" -ForegroundColor Red
    Write-Host "请手动指定Maven路径或将Maven添加到PATH" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ 找到Maven: $mvnCmd" -ForegroundColor Green
Write-Host ""

# 编译项目
Write-Host "编译项目..." -ForegroundColor Yellow
& $mvnCmd clean package -DskipTests

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 编译成功" -ForegroundColor Green
    Write-Host ""
    
    # 运行项目
    Write-Host "启动后端服务..." -ForegroundColor Yellow
    $jarFile = Get-ChildItem "target\*.jar" | Select-Object -First 1
    if ($jarFile) {
        java -jar $jarFile.FullName
    } else {
        Write-Host "❌ 未找到JAR文件" -ForegroundColor Red
    }
} else {
    Write-Host "❌ 编译失败" -ForegroundColor Red
}
