@echo off
title AI Smart Road Monitoring System - RUN PROJECT
echo ============================================================
echo          STARTING AI + PYTHON + JAVA PROJECT
echo ============================================================

REM ---- Step 1: Start Python Flask AI Server ----
echo.
echo [1] Starting Python AI server...
cd python_ai
start "Flask AI" cmd /c "python api_server.py"
cd ..

echo Waiting for Flask server to start (5 seconds)...
timeout /t 5 >nul

REM ---- Step 2: Start Java Spring Boot ----
echo.
echo [2] Starting Spring Boot application...
start "Spring Boot" cmd /c "mvn spring-boot:run"

echo Waiting for Spring Boot server to start (10 seconds)...
timeout /t 10 >nul

REM ---- Step 3: Open Dashboard ----
echo.
echo [3] Opening Dashboard in default browser...
start "" "http://localhost:9090/login"

echo.
echo ============================================================
echo           PROJECT STARTED SUCCESSFULLY
echo ============================================================
pause
exit
