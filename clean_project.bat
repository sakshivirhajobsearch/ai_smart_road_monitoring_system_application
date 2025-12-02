@echo off
title AI Smart Road Monitoring System - Auto Clean
echo ============================================================
echo       CLEANING PROJECT (Windows .BAT Cleaner)
echo ============================================================
echo.

REM -------- Delete Eclipse / VSCode Junk --------
echo Deleting IDE junk...
del /f /q .classpath 2>nul
del /f /q .project 2>nul
del /f /q .factorypath 2>nul
del /f /q .pydevproject 2>nul

rmdir /s /q .settings 2>nul
rmdir /s /q .vscode 2>nul

REM -------- Delete build folders --------
echo Deleting build folders...
rmdir /s /q bin 2>nul
rmdir /s /q target 2>nul
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul

REM -------- Delete Python cache --------
echo Deleting Python cache...
for /r %%f in (__pycache__) do (
    rmdir /s /q "%%f" 2>nul
)

REM -------- Delete temp logs --------
echo Deleting logs...
del /f /q *.log 2>nul

REM -------- Delete duplicate SQL / data under bin/ --------
echo Removing duplicate SQL/data subfolders under bin...
rmdir /s /q bin\database 2>nul
rmdir /s /q bin\data 2>nul
rmdir /s /q bin\docs 2>nul
rmdir /s /q bin\python_ai 2>nul
rmdir /s /q bin\scripts 2>nul

REM -------- Delete leftover compiled .class --------
echo Removing compiled Java classes...
for /r %%f in (*.class) do (
    del /f /q "%%f" 2>nul
)

echo.
echo ============================================================
echo            FINAL DIRECTORY STRUCTURE
echo ============================================================

tree /f

echo.
echo Cleanup complete.
pause
exit
