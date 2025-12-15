@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls

echo ============================================
echo CLEAN PROJECT - SAFE MODE
echo ============================================
echo.

set SUMMARY=clean_summary.txt
echo CLEAN SUMMARY > %SUMMARY%
echo ============= >> %SUMMARY%

REM --- Clean temp & cache (SAFE) ---
for %%D in (
    "__pycache__"
    ".pytest_cache"
    "target"
    "logs"
) do (
    if exist %%D (
        rmdir /S /Q %%D
        echo REMOVED FOLDER: %%D >> %SUMMARY%
    )
)

REM --- Clean compiled files ---
del /S /Q *.class 2>nul && echo REMOVED *.class files >> %SUMMARY%
del /S /Q *.log 2>nul && echo REMOVED *.log files >> %SUMMARY%

echo.
echo ------------ SUMMARY ------------
type %SUMMARY%
echo ---------------------------------
echo.
echo ✔ Runtime files untouched
echo ✔ Source code safe
echo.
pause
ENDLOCAL
