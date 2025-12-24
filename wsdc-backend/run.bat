@echo off
echo ====================================
echo WSDC Backend - Build and Run
echo ====================================
echo.

cd /d "%~dp0"

:: Check Java
echo [1/4] Checking Java...
java -version
if errorlevel 1 (
    echo ERROR: Java not found
    pause
    exit /b 1
)
echo.

:: Find Maven
echo [2/4] Finding Maven...
where mvn >nul 2>&1
if %errorlevel% equ 0 (
    echo Found Maven in PATH
    set MVN_CMD=mvn
    goto :compile
)

:: Search for Maven
for %%d in (
    "C:\apache-maven-3.9.6"
    "C:\Program Files\apache-maven-3.9.6"
    "%USERPROFILE%\apache-maven-3.9.6"
) do (
    if exist "%%~d\bin\mvn.cmd" (
        set MVN_CMD=%%~d\bin\mvn.cmd
        echo Found Maven at %%~d
        goto :compile
    )
)

echo ERROR: Maven not found
echo Please install Maven or add it to PATH
pause
exit /b 1

:compile
echo.
echo [3/4] Compiling...
call "%MVN_CMD%" clean package -DskipTests
if errorlevel 1 (
    echo ERROR: Compilation failed
    pause
    exit /b 1
)

echo.
echo [4/4] Starting backend service...
echo Backend will run on http://localhost:8080
echo API Docs: http://localhost:8080/doc.html
echo.
java -jar target\wsdc-backend-1.0.0.jar

pause
