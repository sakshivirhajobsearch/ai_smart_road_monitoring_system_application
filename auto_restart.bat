@echo off
title AUTO RESTART - AI Smart Road Monitoring System

set LOGFILE=auto_restart.log

echo ============================================================
echo      AI SMART ROAD MONITORING SYSTEM - AUTO RESTART         
echo ============================================================
echo Monitoring Flask, Java, MySQL, Python...
echo All logs will be written to %LOGFILE%
echo ------------------------------------------------------------
echo.

:LOOP
echo Checking system health... >> %LOGFILE%

REM ========================================
REM 1. CHECK MYSQL SERVICE
REM ========================================
sc query MySQL80 | findstr /I "RUNNING" >nul
if NOT %errorlevel%==0 (
    echo [%date% %time%] MySQL80 NOT running. Restarting... >> %LOGFILE%
    net start MySQL80 >> %LOGFILE%
)

sc query mysql | findstr /I "RUNNING" >nul
if NOT %errorlevel%==0 (
    echo [%date% %time%] MySQL NOT running. Restarting... >> %LOGFILE%
    net start mysql >> %LOGFILE%
)

REM ========================================
REM 2. CHECK PYTHON PROCESS
REM ========================================
tasklist | findstr /I "python.exe" >nul
if %errorlevel%==1 (
    echo [%date% %time%] Python/Flask NOT running. Restarting... >> %LOGFILE%
    start cmd /k "cd python_ai && python api_server.py"
)

REM ========================================
REM 3. CHECK FLASK HEALTH (PORT 5000)
REM ========================================
curl -s http://127.0.0.1:5000/ >nul
if NOT %errorlevel%==0 (
    echo [%date% %time%] Flask API not responding. Restarting Python... >> %LOGFILE%
    taskkill /F /IM python.exe >nul 2>&1
    start cmd /k "cd python_ai && python api_server.py"
)

REM ========================================
REM 4. CHECK JAVA PROCESS
REM ========================================
tasklist | findstr /I "java.exe" >nul
if %errorlevel%==1 (
    echo [%date% %time%] Java NOT running. Restarting backend... >> %LOGFILE%
    start cmd /k "mvn spring-boot:run"
)

REM ========================================
REM 5. CHECK SPRING BOOT (PORT 9090)
REM ========================================
curl -s http://127.0.0.1:9090/login >nul
if NOT %errorlevel%==0 (
    echo [%date% %time%] Spring Boot NOT responding. Restarting... >> %LOGFILE%
    taskkill /F /IM java.exe >nul 2>&1
    start cmd /k "mvn spring-boot:run"
)

REM ========================================
REM 6. SLEEP & LOOP AGAIN
REM ========================================
echo [%date% %time%] System OK. Checking again in 10 seconds... >> %LOGFILE%
timeout /t 10 >nul
goto LOOP
