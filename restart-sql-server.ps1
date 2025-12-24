Write-Host "====================================="-ForegroundColor Cyan
Write-Host "Restart SQL Server Service" -ForegroundColor Cyan
Write-Host "====================================="-ForegroundColor Cyan
Write-Host ""

Write-Host "[1/2] Restarting SQL Server..." -ForegroundColor Yellow
try {
    net stop MSSQLSERVER
    Start-Sleep -Seconds 3
    net start MSSQLSERVER
    Write-Host "OK: SQL Server restarted" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to restart - $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/2] Testing database connection..." -ForegroundColor Yellow
sqlcmd -S localhost -U wsdcuser -P "Wsdc@2024" -Q "SELECT 'OK' AS Status"

if ($LASTEXITCODE -eq 0) {
    Write-Host "OK: Database connection successful!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Now you can start the backend:" -ForegroundColor Cyan
    Write-Host ".\start-backend.ps1" -ForegroundColor White
} else {
    Write-Host "ERROR: Connection test failed" -ForegroundColor Red
}
