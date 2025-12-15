@echo off
setlocal EnableDelayedExpansion
title AI Smart Road Monitoring – Project Restructure

echo ==================================================
echo   AI SMART ROAD MONITORING – RESTRUCTURE SCRIPT
echo ==================================================
echo.

REM --------- REMOVE JUNK ----------
echo [1/6] Removing build and IDE junk...

for %%D in (
 target bin .settings .vscode .elastic-copilot
 generated-sources generated-test-sources
 maven-status surefire-reports
) do (
  if exist "%%D" (
    echo   Deleting %%D
    rmdir /s /q "%%D"
  )
)

del /s /q *.pyc >nul 2>&1
for /d /r %%P in (__pycache__) do rmdir /s /q "%%P"

REM --------- CREATE STRUCTURE ----------
echo.
echo [2/6] Creating clean directory structure...

for %%D in (
 database\sql
 data\sample
 data\reports
 data\images
 scripts\windows
 scripts\linux
) do (
  if not exist "%%D" mkdir "%%D"
)

REM --------- MOVE SQL ----------
echo.
echo [3/6] Moving SQL files...

if exist mysql_sql (
  move /y mysql_sql\*.sql database\sql\ >nul 2>&1
)

for %%F in (create.sql insert.sql update.sql delete.sql drop.sql reset.sql) do (
  if exist "database\%%F" move /y "database\%%F" database\sql\ >nul 2>&1
)

REM --------- MOVE DATA ----------
echo.
echo [4/6] Moving data files...

for %%F in (json csv xlsx) do (
  if exist data\*.%%F move /y data\*.%%F data\sample\ >nul 2>&1
)

if exist python_ai\data (
  move /y python_ai\data\* data\sample\ >nul 2>&1
)

REM --------- MOVE REPORTS ----------
echo.
echo [5/6] Moving reports & images...

if exist reports (
  move /y reports\* data\reports\ >nul 2>&1
)

if exist images (
  move /y images\* data\images\ >nul 2>&1
)

REM --------- MOVE SCRIPTS ----------
if exist *.bat move /y *.bat scripts\windows\ >nul 2>&1
if exist *.ps1 move /y *.ps1 scripts\windows\ >nul 2>&1
if exist scripts\*.sh move /y scripts\*.sh scripts\linux\ >nul 2>&1

REM --------- CLEAN DUPLICATES ----------
rmdir /s /q mysql_sql 2>nul
rmdir /s /q reports 2>nul
rmdir /s /q images 2>nul
rmdir /s /q dummy_batch_upload 2>nul
rmdir /s /q bin 2>nul

echo.
echo ==================================================
echo   RESTRUCTURE COMPLETED SUCCESSFULLY
echo ==================================================
echo.

REM --------- SHOW FINAL DIRECTORY STRUCTURE ----------
echo FINAL PROJECT DIRECTORY STRUCTURE:
echo --------------------------------------------------
tree /F
echo --------------------------------------------------
echo.

echo IMPORTANT:
echo - Verify the structure shown above
echo - Run application once
echo - Commit only after verification
echo.

REM --------- MUST STOP BEFORE EXIT ----------
pause
exit
