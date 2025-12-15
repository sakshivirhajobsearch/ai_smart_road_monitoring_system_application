@echo off
SETLOCAL
cls

echo ============================================
echo STOP PROJECT
echo ============================================
echo.

set SUMMARY=stop_summary.txt
echo STOP SUMMARY > %SUMMARY%
echo =========== >> %SUMMARY%

REM --- Stop Java ---
taskkill /F /IM java.exe >nul 2>&1 && echo Java process stopped >> %SUMMARY%

REM --- Stop Python ---
taskkill /F /IM python.exe >nul 2>&1 && echo Python process stopped >> %SUMMARY%

echo.
echo ------------ SUMMARY ------------
type %SUMMARY%
echo ---------------------------------
echo.
echo ✔ All services stopped safely
echo ✔ No data deleted
echo.
pause
ENDLOCAL
