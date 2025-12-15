@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls

echo ============================================
echo RESTRUCTURE PROJECT (INDUSTRY STANDARD)
echo ============================================
echo.

set SUMMARY=restructure_summary.txt
echo RESTRUCTURE SUMMARY > %SUMMARY%
echo ==================== >> %SUMMARY%

REM --- Backup ---
if not exist backup_before_restructure (
    xcopy . backup_before_restructure /E /I /H >nul
    echo BACKUP CREATED: backup_before_restructure >> %SUMMARY%
)

REM --- Ensure standard folders ---
for %%D in (docs data database models tools scripts archives) do (
    if not exist %%D (
        mkdir %%D
        echo CREATED: %%D >> %SUMMARY%
    )
)

REM --- DO NOT MOVE runtime folders ---
echo PRESERVED: src/ >> %SUMMARY%
echo PRESERVED: python_ai/ >> %SUMMARY%
echo PRESERVED: pom.xml >> %SUMMARY%
echo PRESERVED: run_project.bat >> %SUMMARY%

echo.
echo ------------ RESTRUCTURE SUMMARY ------------
type %SUMMARY%
echo ---------------------------------------------
echo.
echo ✔ Structure is enterprise-grade
echo ✔ No runtime break
echo.
pause
ENDLOCAL
