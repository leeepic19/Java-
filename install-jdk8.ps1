# Download and Install JDK 8
Write-Host "Installing JDK 8..." -ForegroundColor Cyan

$jdkUrl = "https://download.oracle.com/otn/java/jdk/8u431-b10/e6bfbc6ccd1d4699bb9c92c22b5a3923/jdk-8u431-windows-x64.exe"
$downloadPath = "$env:TEMP\jdk8.exe"

Write-Host "Note: Oracle JDK requires manual download due to license acceptance" -ForegroundColor Yellow
Write-Host "Please visit:" -ForegroundColor White
Write-Host "https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html" -ForegroundColor Cyan
Write-Host ""
Write-Host "Or try using OpenJDK 8:" -ForegroundColor Yellow
Write-Host "https://adoptium.net/temurin/releases/?version=8" -ForegroundColor Cyan
Write-Host ""

# Try using winget to install Temurin JDK 8
Write-Host "Attempting to install Temurin JDK 8 using winget..." -ForegroundColor Yellow
try {
    winget install EclipseAdoptium.Temurin.8.JDK --accept-package-agreements --accept-source-agreements
} catch {
    Write-Host "winget failed: $_" -ForegroundColor Red
    Write-Host "Please install JDK 8 manually" -ForegroundColor Yellow
}
