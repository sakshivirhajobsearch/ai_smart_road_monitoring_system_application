Clear-Host
$logfile = "auto_restart.log"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " AI SMART ROAD MONITORING SYSTEM - AUTO RESTART (PowerShell)" -ForegroundColor Green
Write-Host "============================================================"
Write-Host "Monitoring Flask, Java, MySQL, Python continuously..."
Write-Host "Logs: $logfile"
Write-Host "------------------------------------------------------------"

function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content $logfile "$timestamp  $msg"
}

function Start-Flask {
    Log "Restarting Flask API..."
    Start-Process powershell -ArgumentList "cd python_ai; python api_server.py" -WindowStyle Minimized
}

function Start-Java {
    Log "Restarting Java Spring Boot..."
    Start-Process powershell -ArgumentList "mvn spring-boot:run" -WindowStyle Minimized
}

while ($true) {

    # ----------------------------------------
    # 1. Check MySQL Service
    # ----------------------------------------
    $mysql = Get-Service -Name "MySQL80" -ErrorAction SilentlyContinue
    if ($mysql.Status -ne "Running") {
        Log "MySQL80 NOT running → starting..."
        Start-Service "MySQL80"
    }

    # ----------------------------------------
    # 2. Check Python Process
    # ----------------------------------------
    $pythonRunning = Get-Process python -ErrorAction SilentlyContinue
    if (-not $pythonRunning) {
        Log "Python/Flask NOT running → starting Flask..."
        Start-Flask
    }

    # ----------------------------------------
    # 3. Check Flask API (port 5000)
    # ----------------------------------------
    try {
        $flask = Invoke-WebRequest -Uri "http://127.0.0.1:5000/" -TimeoutSec 3 -ErrorAction Stop
    } catch {
        Log "Flask API not responding → restarting Python..."
        Get-Process python -ErrorAction SilentlyContinue | Stop-Process -Force
        Start-Flask
    }

    # ----------------------------------------
    # 4. Check Java Process
    # ----------------------------------------
    $javaRunning = Get-Process java -ErrorAction SilentlyContinue
    if (-not $javaRunning) {
        Log "Java backend NOT running → starting Spring Boot..."
        Start-Java
    }

    # ----------------------------------------
    # 5. Check Spring Boot (port 9090)
    # ----------------------------------------
    try {
        $spring = Invoke-WebRequest -Uri "http://127.0.0.1:9090/login" -TimeoutSec 3 -ErrorAction Stop
    } catch {
        Log "Spring Boot not responding → restarting Java..."
        Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force
        Start-Java
    }

    # ----------------------------------------
    # Loop Wait
    # ----------------------------------------
    Log "System OK → checking again in 10 seconds..."
    Start-Sleep -Seconds 10
}
