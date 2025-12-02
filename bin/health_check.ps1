Write-Host "============================================" -ForegroundColor Cyan
Write-Host " AI SMART ROAD MONITORING - HEALTH CHECK" -ForegroundColor Cyan
Write-Host "============================================`n"

# -------------------------------
# CHECK MYSQL
# -------------------------------
Write-Host "Checking MySQL service..." -ForegroundColor Yellow
$mysqlRunning = Get-Service -Name "MySQL80","mysql" -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq "Running"}

if ($mysqlRunning) {
    Write-Host "✔ MySQL Running" -ForegroundColor Green
} else {
    Write-Host "✖ MySQL NOT Running" -ForegroundColor Red
}

# -------------------------------
# CHECK PYTHON PROCESS
# -------------------------------
Write-Host "`nChecking Python / Flask..." -ForegroundColor Yellow
$python = Get-Process python -ErrorAction SilentlyContinue
if ($python) {
    Write-Host "✔ Python Running" -ForegroundColor Green
} else {
    Write-Host "✖ Python NOT Running" -ForegroundColor Red
}

# -------------------------------
# CHECK FLASK SERVER IS RESPONDING
# -------------------------------
Write-Host "`nChecking Flask API endpoint..." -ForegroundColor Yellow
try {
    $r = Invoke-WebRequest -Uri "http://127.0.0.1:5000/" -TimeoutSec 3 -ErrorAction Stop
    if ($r.StatusCode -eq 200) {
        Write-Host "✔ Flask API Responding" -ForegroundColor Green
    }
} catch {
    Write-Host "✖ Flask API NOT Responding" -ForegroundColor Red
}

# -------------------------------
# CHECK JAVA SERVER (PORT 9090)
# -------------------------------
Write-Host "`nChecking Java Spring Boot Server..." -ForegroundColor Yellow
try {
    $j = Invoke-WebRequest -Uri "http://127.0.0.1:9090/login" -TimeoutSec 3 -ErrorAction Stop
    Write-Host "✔ Java Spring Boot Responding" -ForegroundColor Green
} catch {
    Write-Host "✖ Java Spring Boot NOT responding" -ForegroundColor Red
}

# -------------------------------
# CHECK JAVA PROCESS
# -------------------------------
Write-Host "`nChecking Java process..." -ForegroundColor Yellow
$java = Get-Process java -ErrorAction SilentlyContinue
if ($java) {
    Write-Host "✔ Java Running" -ForegroundColor Green
} else {
    Write-Host "✖ Java NOT Running" -ForegroundColor Red
}

# -------------------------------
# CHECK IMPORTANT FILES
# -------------------------------
Write-Host "`nChecking essential files..." -ForegroundColor Yellow

$files = @(
    "potholes_data.json",
    "road_data.json",
    "dashboard_data.json",
    "python_ai\models\pothole_model.pkl"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "✔ $file found" -ForegroundColor Green
    } else {
        Write-Host "✖ $file missing" -ForegroundColor Red
    }
}

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host "       HEALTH CHECK COMPLETED" -ForegroundColor Cyan
Write-Host "============================================"
