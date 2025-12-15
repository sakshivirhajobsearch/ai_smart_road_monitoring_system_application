@echo off
setlocal enabledelayedexpansion

echo =============================================================
echo         SMART ROAD SYSTEM - DEEP CLEAN (SAFE MODE)
echo =============================================================

REM -------------------------------
REM IDE FOLDER REMOVAL
REM -------------------------------
for %%d in (".idea" ".vscode" ".classpath" ".project" ".settings") do (
    if exist %%d (
        echo Removing IDE folder: %%d
        rmdir /s /q %%d 2>nul
    )
)

REM -------------------------------
REM REMOVE MAVEN TARGET
REM -------------------------------
if exist target (
    echo Removing Maven target/
    rmdir /s /q target
)

REM -------------------------------
REM CLEAN PYTHON CACHE
REM -------------------------------
echo Cleaning __pycache__ directories...
for /r python_ai %%d in (__pycache__) do (
    rmdir /s /q "%%d"
)

REM -------------------------------
REM REMOVE PYTHON TEMP FILES
REM -------------------------------
echo Cleaning Python temporary files (*.tmp *.bak *.cache)...
for /r python_ai %%f in (*.tmp *.bak *.cache) do (
    del /q "%%f"
)

REM -------------------------------
REM CLEAN PYTHON UPLOADS
REM -------------------------------
echo Cleaning Python uploaded images & sensor files...
for /r python_ai\uploads\images %%f in (*.jpg *.jpeg *.png *.bmp *.gif) do (
    del /q "%%f"
)

for /r python_ai\uploads\sensor %%f in (*.csv *.xlsx *.txt) do (
    del /q "%%f"
)

REM -------------------------------
REM CLEAN PYTHON LOG FILES
REM -------------------------------
echo Cleaning log files...
for /r python_ai %%f in (*.log) do (
    del /q "%%f"
)

REM -------------------------------
REM SAFETY PROTECTION (DO NOT DELETE DATASETS)
REM -------------------------------
echo Protecting dataset folders:
echo   - ai_dummy_dataset
echo   - ai_dummy_dataset_large
echo   - dummy_data_files

echo =============================================================
echo DEEP CLEAN COMPLETE ✓
echo =============================================================
pause
