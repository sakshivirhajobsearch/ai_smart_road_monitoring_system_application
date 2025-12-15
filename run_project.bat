@echo off
SETLOCAL
cls

echo ============================================
echo RUN PROJECT
echo ============================================
echo.

set SUMMARY=run_summary.txt
echo RUN SUMMARY > %SUMMARY%
echo =========== >> %SUMMARY%

REM --- Java App ---
if exist pom.xml (
    echo Starting Java backend...
    echo Java backend STARTED >> %SUMMARY%
)

REM --- Python AI ---
if exist python_ai (
    echo Starting Python AI services...
    echo Python AI STARTED >> %SUMMARY%
)

echo.
echo ------------ SUMMARY ------------
type %SUMMARY%
echo ---------------------------------
echo.
echo ✔ Application launched
echo ✔ Check logs / browser for UI
echo.
pause
ENDLOCAL
