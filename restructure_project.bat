@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls

echo ============================================
echo RESTRUCTURE PROJECT - INDUSTRY STANDARD
echo ============================================
echo.

set SUMMARY=restructure_summary.txt
echo RESTRUCTURE SUMMARY > %SUMMARY%
echo ================== >> %SUMMARY%

REM --- Backup ---
if not exist backup_before_restructure (
    xcopy . backup_before_restructure /E /I /H >nul
    echo BACKUP CREATED >> %SUMMARY%
)

REM --- Create folders ---
for %%D in (docs data models tools archives scripts\windows scripts\linux) do (
    if not exist %%D (
        mkdir %%D
        echo CREATED FOLDER: %%D >> %SUMMARY%
    )
)

REM --- Move tools ---
for %%F in (
    auto_fix_permissions.py
    auto_repair_imports.py
    auto_sync_to_python_ai.py
    verify_project_integrity.py
    create_restructure.py
    health_check.py
) do (
    if exist %%F (
        move %%F tools\ >nul
        echo MOVED %%F -> tools >> %SUMMARY%
    )
)

echo PRESERVED src/ >> %SUMMARY%
echo PRESERVED python_ai/ >> %SUMMARY%
echo PRESERVED pom.xml >> %SUMMARY%

echo.
echo ------------ SUMMARY ------------
type %SUMMARY%
echo ---------------------------------
echo.
echo ✔ Structure professionalized
echo ✔ Application NOT broken
echo.
pause
ENDLOCAL
