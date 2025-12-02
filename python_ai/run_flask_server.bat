@echo off
cd /d %~dp0

title FLASK API TEST CLIENT
echo ==============================
echo    Testing AI API Endpoints
echo ==============================
echo.

python test_api.py

pause
