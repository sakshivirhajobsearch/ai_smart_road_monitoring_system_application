@echo off
title STOP - AI Smart Road Monitoring System
echo ============================================
echo   STOPPING AI SMART ROAD MONITORING SYSTEM
echo ============================================
echo.

echo Stopping Flask / Python processes...
taskkill /F /IM python.exe >nul 2>&1
taskkill /F /IM pythonw.exe >nul 2>&1

echo Stopping Java Spring Boot Server...
taskkill /F /IM java.exe >nul 2>&1
taskkill /F /IM javaw.exe >nul 2>&1

echo Stopping MySQL Server...
net stop MySQL80 >nul 2>&1
net stop mysql >nul 2>&1

echo.
echo ============================================
echo       ALL RELATED SERVICES STOPPED
echo ============================================
pause
