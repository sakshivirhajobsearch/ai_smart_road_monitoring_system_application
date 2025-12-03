@echo off
setlocal enabledelayedexpansion

echo.
echo ============================================================
echo          CLEANING PROJECT (Windows Clean Script)
echo ============================================================
echo.

REM --------------------------
REM 1. Remove IDE metadata
REM --------------------------
echo [1] Removing IDE metadata...
for %%d in (".idea" ".vscode" ".classpath" ".project" ".settings") do (
    if exist %%d (
        echo    - deleting %%d
        rmdir /s /q %%d 2>nul
    )
)

REM --------------------------
REM 2. Clean Maven build folders
REM --------------------------
echo [2] Removing build folders...
if exist target (
    echo    - deleting /target
    rmdir /s /q target
)

REM --------------------------
REM 3. Remove Python cache
REM --------------------------
echo [3] Removing Python __pycache__...
for /r python_ai %%d in (__pycache__) do (
    echo    - deleting %%d
    rmdir /s /q "%%d"
)

REM --------------------------
REM 4. Remove logs
REM --------------------------
echo [4] Removing logs...
for /r %%f in (*.log) do (
    echo    - deleting %%f
    del /q "%%f"
)

REM --------------------------
REM 5. Remove auto-generated JSON (NOT real JSON)
REM --------------------------
echo [5] Removing auto-generated JSON data...

if exist potholes_data.json del /q potholes_data.json
if exist road_data.json del /q road_data.json

REM python_ai\data
if exist python_ai\data\dummy_pothole_data.json del /q python_ai\data\dummy_pothole_data.json
if exist python_ai\data\dummy_road_data.json del /q python_ai\data\dummy_road_data.json

REM --------------------------
REM 6. Clean Python uploads folder (ONLY auto-generated files)
REM --------------------------
echo [6] Cleaning Python uploads (preserving model files)...

REM delete all uploaded images
for /r python_ai\uploads\images %%f in (*.jpg *.jpeg *.png *.csv) do (
    echo    - deleting uploaded %%~nxf
    del /q "%%f"
)

REM delete sensor uploaded files
for /r python_ai\uploads\sensor %%f in (*.csv *.xlsx) do (
    echo    - deleting uploaded %%~nxf
    del /q "%%f"
)

echo.
echo ============================================================
echo                FINAL DIRECTORY STRUCTURE
echo ============================================================
tree /f /a
echo ============================================================
echo   CLEAN COMPLETE ✔
echo ============================================================

endlocal
pause
