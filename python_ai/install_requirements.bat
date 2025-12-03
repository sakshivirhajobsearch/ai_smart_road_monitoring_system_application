@echo off
cd /d %~dp0

echo ==============================
echo   INSTALLING PYTHON PACKAGES
echo ==============================
echo.

pip install -r requirements.txt

echo.
echo ✅ All dependencies installed.
pause
