@echo off
echo ============================================================
echo      AI SMART ROAD MONITORING SYSTEM - AUTO BUILD + RUN
echo ============================================================

echo [1] Cleaning old build...
call clean_project.bat

echo.
echo [2] Building Maven project...
mvn clean install -DskipTests

IF %ERRORLEVEL% NEQ 0 (
    echo ❌ Maven build FAILED. Fix errors first.
    pause
    exit /b
)

echo.
echo [3] Starting Spring Boot application...
mvn spring-boot:run

pause
