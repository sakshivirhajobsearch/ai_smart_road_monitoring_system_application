@echo off
title PYTHON ENVIRONMENT CHECK
echo ==============================
echo   Checking Python Environment
echo ==============================
echo.

python --version
if %errorlevel% neq 0 (
    echo ❌ Python not installed or PATH broken.
    pause
    exit /b
)

pip --version
if %errorlevel% neq 0 (
    echo ❌ Pip not installed.
    pause
    exit /b
)

echo.
echo Checking required libraries...
pip list | findstr Flask
pip list | findstr numpy
pip list | findstr opencv
pip list | findstr joblib
pip list | findstr Pillow

echo.
echo ✅ Python environment OK.
pause
