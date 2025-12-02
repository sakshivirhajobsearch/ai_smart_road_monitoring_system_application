Write-Host "============================================================"
Write-Host "     STARTING AI + PYTHON + JAVA PROJECT"
Write-Host "============================================================`n"

# ------------------------------
# Step 1: Start Python Flask AI
# ------------------------------
Write-Host "[1] Starting Python Flask AI server..."
Start-Process powershell -ArgumentList "python ./python_ai/api_server.py"
Start-Sleep -Seconds 5

# ------------------------------
# Step 2: Start Java Spring Boot
# ------------------------------
Write-Host "`n[2] Starting Spring Boot server..."
Start-Process powershell -ArgumentList "mvn spring-boot:run"
Start-Sleep -Seconds 10

# ------------------------------
# Step 3: Open Web Dashboard
# ------------------------------
Write-Host "`n[3] Opening dashboard in browser..."
Start-Process "http://localhost:9090/login"

Write-Host "`n============================================================"
Write-Host "          PROJECT STARTED SUCCESSFULLY"
Write-Host "============================================================"
pause
exit
