@echo off
title AI Smart Road Monitoring System - Auto Clean
echo ============================================================
echo            CLEANING PROJECT (Windows Clean Script)
echo ============================================================
echo.

REM -----------------------------
REM Delete common IDE junk
REM -----------------------------
echo [1] Removing IDE metadata...
del /f /q .classpath 2>nul
del /f /q .factorypath 2>nul
del /f /q .project 2>nul
del /f /q .pydevproject 2>nul

rmdir /s /q .settings 2>nul
rmdir /s /q .vscode 2>nul

REM -----------------------------
REM Delete build artifacts
REM -----------------------------
echo [2] Removing build folders...
rmdir /s /q target 2>nul
rmdir /s /q bin 2>nul
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul

REM -----------------------------
REM Python cache cleanup
REM -----------------------------
echo [3] Removing Python __pycache__...
for /r %%d in (__pycache__) do rmdir /s /q "%%d" 2>nul

REM -----------------------------
REM Remove logs
REM -----------------------------
echo [4] Removing logs...
del /f /q *.log 2>nul
rmdir /s /q python_ai\logs 2>nul

REM -----------------------------
REM Auto-generated JSON cleaned but NOT main JSON
REM -----------------------------
echo [5] Removing auto-generated JSON data...
del /f /q dashboard_data.json 2>nul

REM -----------------------------
REM Show final directory structure
REM -----------------------------
echo.
echo ============================================================
echo               FINAL DIRECTORY STRUCTURE
echo ============================================================
tree /f
echo.
echo Cleanup complete.
pause
exit
