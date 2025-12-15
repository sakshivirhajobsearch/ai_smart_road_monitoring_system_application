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

REM --- Java ---
if exist pom.xml (
    echo Java project detected
    echo Java project detected >> %SUMMARY%
)

REM --- Python ---
if exist python_ai (
    echo Python AI module detected
    echo Python AI module detected >> %SUMMARY%
)

echo.
echo ------------ RUN SUMMARY ------------
type %SUMMARY%
echo ------------------------------------
echo.
echo ✔ Project ready to run
echo ✔ Use Maven / Python commands as needed
echo.
pause
ENDLOCAL
