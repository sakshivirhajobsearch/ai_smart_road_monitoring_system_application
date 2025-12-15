Write-Host "============================================" -ForegroundColor Cyan
Write-Host " AI SMART ROAD MONITORING SYSTEM - LAUNCHER " -ForegroundColor Cyan
Write-Host "============================================"
Write-Host ""

# ============================
# 1. START MYSQL SERVER
# ============================
Write-Host "Starting MySQL Server..." -ForegroundColor Yellow
Start-Service -Name "MySQL80" -ErrorAction SilentlyContinue
Start-Service -Name "mysql" -ErrorAction SilentlyContinue
Write-Host "MySQL service started."
Write-Host ""

# ============================
# 2. START FLASK AI SERVER
# ============================
Write-Host "Starting Flask AI Server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "cd python_ai; python api_server.py"
Write-Host "Waiting 6 seconds for Flask to initialize..."
Start-Sleep -Seconds 6
Write-Host "Flask AI Server started."
Write-Host ""

# ============================
# 3. START JAVA SPRING BOOT
# ============================
Write-Host "Starting Java Spring Boot Backend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "mvn spring-boot:run"
Write-Host "Waiting 10 seconds for Java Server to initialize..."
Start-Sleep -Seconds 10
Write-Host "Java Spring Boot Server started."
Write-Host ""

# ============================
# 4. START SMART ROAD GUI
# ============================
Write-Host "Launching SmartRoadDashboard GUI..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "cd src\main\java; java com.ai.smart.road.monitoring.system.application.gui.SmartRoadDashboardLauncher"
Write-Host "GUI launched."
Write-Host ""

Write-Host "============================================" -ForegroundColor Green
Write-Host "       ALL SYSTEMS STARTED SUCCESSFULLY      " -ForegroundColor Green
Write-Host "============================================"
