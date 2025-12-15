@echo off
SETLOCAL
cls

echo ============================================
echo STOP PROJECT
echo ============================================
echo.

set SUMMARY=stop_summary.txt
echo STOP SUMMARY > %SUMMARY%
echo ============ >> %SUMMARY%

REM --- Stop Java ---
taskkill /F /IM java.exe >nul 2>&1
if %ERRORLEVEL%==0 (
    echo Java process stopped >> %SUMMARY%
) else (
    echo No Java process found >> %SUMMARY%
)

REM --- Stop Python ---
taskkill /F /IM python.exe >nul 2>&1
if %ERRORLEVEL%==0 (
    echo Python process stopped >> %SUMMARY%
) else (
    echo No Python process found >> %SUMMARY%
)

echo.
echo ------------ STOP SUMMARY ------------
type %SUMMARY%
echo -------------------------------------
echo.
echo ✔ Application stopped safely
echo ✔ No data deleted
echo.
pause
ENDLOCAL
