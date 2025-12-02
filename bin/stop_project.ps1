Write-Host "============================================" -ForegroundColor Yellow
Write-Host " STOPPING AI SMART ROAD MONITORING SYSTEM " -ForegroundColor Yellow
Write-Host "============================================"

Write-Host "`nStopping Python / Flask..." -ForegroundColor Cyan
Get-Process python -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-Process pythonw -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Stopping Java Server..." -ForegroundColor Cyan
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-Process javaw -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Stopping MySQL Service..." -ForegroundColor Cyan
Stop-Service -Name "MySQL80" -ErrorAction SilentlyContinue
Stop-Service -Name "mysql" -ErrorAction SilentlyContinue

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "       ALL SERVICES STOPPED SUCCESSFULLY       " -ForegroundColor Green
Write-Host "============================================"
