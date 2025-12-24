$ErrorActionPreference = "Stop"

# Enable TLS 1.2 for downloads
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$workDir = $PSScriptRoot
$envDir = Join-Path $workDir "env"
if (!(Test-Path $envDir)) { New-Item -ItemType Directory -Path $envDir | Out-Null }

# --- 1. Setup Maven ---
$mavenVer = "3.9.6"
$mavenZip = Join-Path $envDir "maven.zip"
$mavenDir = Join-Path $envDir "apache-maven-$mavenVer"

if (!(Test-Path $mavenDir)) {
    Write-Host "Downloading Maven $mavenVer..."
    $mavenUrl = "https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/$mavenVer/apache-maven-$mavenVer-bin.zip"
    # Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
    curl.exe -L -o $mavenZip $mavenUrl
    
    Write-Host "Extracting Maven..."
    Expand-Archive -Path $mavenZip -DestinationPath $envDir -Force
    Remove-Item $mavenZip
} else {
    Write-Host "Maven found."
}

# --- 2. Setup JDK 11 ---
$jdkZip = Join-Path $envDir "jdk.zip"
# Microsoft Build of OpenJDK 11
$jdkUrl = "https://aka.ms/download-jdk/microsoft-jdk-11-windows-x64.zip"
# We need to find the extracted folder name dynamically or assume it
$jdkParentDir = Join-Path $envDir "jdk-install"

if (!(Test-Path $jdkParentDir)) {
    Write-Host "Downloading OpenJDK 11..."
    # Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkZip
    curl.exe -L -o $jdkZip $jdkUrl
    
    Write-Host "Extracting JDK..."
    Expand-Archive -Path $jdkZip -DestinationPath $jdkParentDir -Force
    Remove-Item $jdkZip
} else {
    Write-Host "JDK found."
}

# Find the actual JDK home inside the extracted folder
$jdkHome = Get-ChildItem -Path $jdkParentDir -Directory | Select-Object -First 1 -ExpandProperty FullName
Write-Host "JDK Home: $jdkHome"

# --- 2.5 Setup SQL Server Auth DLL ---
$dllUrl = "https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc_auth/9.4.1.x64/mssql-jdbc_auth-9.4.1.x64.dll"
$dllPath = Join-Path $jdkHome "bin\mssql-jdbc_auth-9.4.1.x64.dll"

if (!(Test-Path $dllPath)) {
    Write-Host "Downloading SQL Server Auth DLL..."
    curl.exe -L -o $dllPath $dllUrl
}

# --- 3. Configure Environment (Session only) ---
$env:JAVA_HOME = $jdkHome
$env:MAVEN_HOME = $mavenDir
$env:Path = "$($env:MAVEN_HOME)\bin;$($env:JAVA_HOME)\bin;$($env:Path)"

Write-Host "Environment configured."
mvn -version
java -version

# --- 4. Run Project ---
Write-Host "Starting Project..."
mvn tomcat7:run
