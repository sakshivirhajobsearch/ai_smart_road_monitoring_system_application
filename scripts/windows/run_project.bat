@echo off
setlocal EnableDelayedExpansion
title AI Smart Road Monitoring – RUN PROJECT

echo ===================================================
echo  AI SMART ROAD MONITORING SYSTEM – STARTUP SCRIPT
echo ===================================================
echo.

REM ---------------------------------------------------
REM CONFIGURATION (EDIT IF NEEDED)
REM ---------------------------------------------------
set PROJECT_ROOT=%~dp0..
set PYTHON_DIR=%PROJECT_ROOT%\python_ai
set JAVA_JAR=%PROJECT_ROOT%\target\ai_smart_road_monitoring_system_application-0.0.1-SNAPSHOT.jar
set PYTHON_EXE=python
set AI_API_FILE=api\api_server.py

REM ---------------------------------------------------
REM CHECK JAVA
REM ---------------------------------------------------
echo Checking Java...
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Java is NOT installed or not in PATH
    pause
    exit /b
)
echo ✔ Java OK
echo.

REM ---------------------------------------------------
REM CHECK PYTHON
REM ---------------------------------------------------
echo Checking Python...
%PYTHON_EXE% --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is NOT installed or not in PATH
    pause
    exit /b
)
echo ✔ Python OK
echo.

REM ---------------------------------------------------
REM START PYTHON AI SERVICES
REM ---------------------------------------------------
echo Starting Python AI services...
cd /d "%PYTHON_DIR%"

if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
    echo ✔ Python virtual environment activated
) else (
    echo ⚠ No virtual environment found, using system Python
)

REM --- Start AI API Server ---
echo Launching AI API server...
start "AI API Server" cmd /k "%PYTHON_EXE% %AI_API_FILE%"

REM --- Optional: background AI loader ---
if exist utils\load_data_to_mysql.py (
    echo Launching AI data loader...
    start "AI Data Loader" cmd /k "%PYTHON_EXE% utils\load_data_to_mysql.py"
)

echo ✔ Python AI services started
echo.

REM ---------------------------------------------------
REM START JAVA SPRING BOOT APPLICATION
REM ---------------------------------------------------
echo Starting Java Spring Boot application...
cd /d "%PROJECT_ROOT%"

if not exist "%JAVA_JAR%" (
    echo ❌ Spring Boot JAR not found:
    echo %JAVA_JAR%
    echo Run: mvn clean package
    pause
    exit /b
)

start "Spring Boot Application" cmd /k "java -jar %JAVA_JAR%"

echo ✔ Java application started
echo.

REM ---------------------------------------------------
REM OPTIONAL: OPEN DASHBOARD IN BROWSER
REM ---------------------------------------------------
echo Opening dashboard in browser...
timeout /t 5 >nul
start http://localhost:8080/login

REM ---------------------------------------------------
REM STATUS INFO
REM ---------------------------------------------------
echo.
echo ===================================================
echo  ALL SERVICES ARE RUNNING
echo ===================================================
echo.
echo Java Dashboard : http://localhost:8080
echo Python AI API  : http://localhost:5000
echo.
echo Press CTRL+C in individual windows to stop services
echo.

REM ---------------------------------------------------
REM MUST STOP BEFORE EXIT
REM ---------------------------------------------------
pause
exit /b
