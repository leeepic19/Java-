@echo off
echo =====================================
echo Restart SQL Server (Admin Required)
echo =====================================
echo.

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ERROR: Please run as Administrator!
    echo Right-click this file and select "Run as administrator"
    pause
    exit /b 1
)

echo [1/3] Changing authentication mode...
sqlcmd -S localhost -E -Q "EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2"

echo.
echo [2/3] Restarting SQL Server...
net stop MSSQLSERVER
timeout /t 3 /nobreak >nul
net start MSSQLSERVER
timeout /t 5 /nobreak >nul

echo.
echo [3/3] Testing connection...
sqlcmd -S localhost -U wsdcuser -P "Wsdc@2024" -d wsdc -Q "SELECT 'OK' AS Status"

if %errorLevel% EQU 0 (
    echo.
    echo SUCCESS! Database is ready.
    echo Now run: start-backend.ps1
) else (
    echo.
    echo ERROR: Connection test failed
)

echo.
pause
