@echo off
title AI Smart Road Monitoring - HEALTH CHECK
echo ============================================
echo     AI SMART ROAD MONITORING - HEALTH CHECK
echo ============================================
echo.

REM ============================================
REM CHECK MYSQL SERVICE
REM ============================================
echo Checking MySQL service...
sc query MySQL80 | findstr /I "RUNNING" >nul
if %errorlevel%==0 (
    echo   ✔ MySQL80 is RUNNING
) else (
    sc query mysql | findstr /I "RUNNING" >nul
    if %errorlevel%==0 (
        echo   ✔ mysql service is RUNNING
    ) else (
        echo   ✖ MySQL is NOT running
    )
)
echo.

REM ============================================
REM CHECK PYTHON PROCESS
REM ============================================
echo Checking Python / Flask processes...
tasklist | findstr /I "python.exe" >nul
if %errorlevel%==0 (
    echo   ✔ Python process is RUNNING
) else (
    echo   ✖ Python is NOT running
)
echo.

REM ============================================
REM CHECK FLASK SERVER (PORT 5000)
REM ============================================
echo Checking Flask server at http://127.0.0.1:5000 ...
curl -s http://127.0.0.1:5000/ >nul
if %errorlevel%==0 (
    echo   ✔ Flask API is RESPONDING
) else (
    echo   ✖ Flask API NOT responding
)
echo.

REM ============================================
REM CHECK JAVA SPRING BOOT SERVER (PORT 9090)
REM ============================================
echo Checking Java Spring Boot at http://127.0.0.1:9090/login ...
curl -s http://127.0.0.1:9090/login >nul
if %errorlevel%==0 (
    echo   ✔ Java Spring Boot is RESPONDING
) else (
    echo   ✖ Java Spring Boot NOT responding
)
echo.

REM ============================================
REM CHECK JAVA PROCESS
REM ============================================
echo Checking Java process...
tasklist | findstr /I "java.exe" >nul
if %errorlevel%==0 (
    echo   ✔ Java process is RUNNING
) else (
    echo   ✖ Java is NOT running
)
echo.

REM ============================================
REM CHECK IMPORTANT FILES
REM ============================================
echo Checking important files in project directory...

if exist potholes_data.json (
    echo   ✔ potholes_data.json found
) else (
    echo   ✖ potholes_data.json MISSING
)

if exist road_data.json (
    echo   ✔ road_data.json found
) else (
    echo   ✖ road_data.json MISSING
)

if exist dashboard_data.json (
    echo   ✔ dashboard_data.json found
) else (
    echo   ✖ dashboard_data.json MISSING
)

if exist python_ai\models\pothole_model.pkl (
    echo   ✔ pothole_model.pkl found
) else (
    echo   ✖ pothole_model.pkl MISSING
)

echo.
echo ============================================
echo       HEALTH CHECK COMPLETED
echo ============================================
pause
