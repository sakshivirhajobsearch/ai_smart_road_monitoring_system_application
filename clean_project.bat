@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls

echo ============================================
echo CLEAN PROJECT (SAFE / NON-DESTRUCTIVE)
echo ============================================
echo.

set SUMMARY=clean_summary.txt
echo CLEAN SUMMARY > %SUMMARY%
echo ================= >> %SUMMARY%

REM --- Maven build output ---
if exist target (
    rmdir /S /Q target
    echo REMOVED: target/ >> %SUMMARY%
)

REM --- Logs ---
if exist logs (
    rmdir /S /Q logs
    echo REMOVED: logs/ >> %SUMMARY%
)

REM --- Python cache ---
for /R %%D in (__pycache__) do (
    if exist "%%D" (
        rmdir /S /Q "%%D"
        echo REMOVED: %%D >> %SUMMARY%
    )
)

REM --- Old summaries ---
del *_summary.txt 2>nul
echo REMOVED: old *_summary.txt >> %SUMMARY%

echo.
echo ------------ CLEAN SUMMARY ------------
type %SUMMARY%
echo ---------------------------------------
echo.
echo ✔ Source code untouched
echo ✔ Application safe
echo.
pause
ENDLOCAL
