@echo off
setlocal enabledelayedexpansion
title AI Smart Road Monitoring System - Safe Cleanup

echo =====================================================
echo   AI SMART ROAD MONITORING SYSTEM
echo   SAFE PROJECT CLEANUP SCRIPT
echo =====================================================
echo.
echo This will remove:
echo  - Maven build artifacts (target/)
echo  - Generated sources
echo  - Python cache and logs
echo  - IDE junk files
echo  - Temporary output folders
echo.
echo IMPORTANT:
echo  - Source code, data, docs, Git will NOT be touched
echo.

set /p CONFIRM=Proceed with cleanup? (Y/N): 
if /I NOT "%CONFIRM%"=="Y" (
    echo Cleanup cancelled.
    goto :EOF
)

echo.
echo 🔥 Cleaning in progress...
echo.

REM -----------------------------------------------------
REM Maven / Java build artifacts
REM -----------------------------------------------------
for %%d in (target generated-sources generated-test-sources test-classes) do (
    if exist %%d (
        echo Removing %%d/
        rmdir /s /q %%d
    )
)

REM -----------------------------------------------------
REM Python cache
REM -----------------------------------------------------
for /d /r %%d in (__pycache__) do (
    if exist "%%d" (
        echo Removing %%d
        rmdir /s /q "%%d"
    )
)

del /s /q *.pyc 2>nul

REM -----------------------------------------------------
REM Python logs
REM -----------------------------------------------------
if exist python_ai\logs (
    echo Removing python_ai\logs\
    rmdir /s /q python_ai\logs
)

REM -----------------------------------------------------
REM IDE / tooling junk
REM -----------------------------------------------------
for %%f in (.pydevproject .factorypath) do (
    if exist %%f (
        echo Removing %%f
        del /q %%f
    )
)

REM -----------------------------------------------------
REM Temporary output folders
REM -----------------------------------------------------
for %%d in (output outputs_arch build dist tmp) do (
    if exist %%d (
        echo Removing %%d/
        rmdir /s /q %%d
    )
)

REM -----------------------------------------------------
REM OS junk
REM -----------------------------------------------------
del /s /q Thumbs.db desktop.ini 2>nul

echo.
echo ✅ CLEANUP COMPLETED SUCCESSFULLY
echo -----------------------------------------------------
echo Project is clean and ready to build/run.
echo.
pause
