@echo off
title AI Smart Road Monitoring - Full System Launcher
echo ============================================
echo   AI SMART ROAD MONITORING SYSTEM - LAUNCHER
echo ============================================
echo.

REM ================================
REM 1. START MYSQL SERVER
REM ================================
echo Starting MySQL service...
net start MySQL80 >nul 2>&1
net start mysql >nul 2>&1
echo MySQL service started.
echo.

REM ================================
REM 2. START PYTHON FLASK AI SERVER
REM ================================
echo Starting Flask AI Server...
start cmd /k "cd python_ai && python api_server.py"
echo Waiting 6 seconds for Flask server to initialize...
timeout /t 6 >nul
echo Flask AI Server started.
echo.

REM ================================
REM 3. START JAVA SPRING BOOT SERVER
REM ================================
echo Starting Java Spring Boot Backend...
start cmd /k "mvn spring-boot:run"
echo Waiting 10 seconds for Java server to initialize...
timeout /t 10 >nul
echo Java Spring Boot Server started.
echo.

REM ================================
REM 4. START SMART ROAD GUI DASHBOARD
REM ================================
echo Starting SmartRoadDashboard GUI...
start cmd /k "cd src\main\java && java com.ai.smart.road.monitoring.system.application.gui.SmartRoadDashboardLauncher"
echo GUI launched.
echo.

echo ============================================
echo       ALL SYSTEMS STARTED SUCCESSFULLY
echo ============================================
pause
