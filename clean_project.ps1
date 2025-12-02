Write-Host "============================================"
Write-Host "   Cleaning Project (PowerShell Version)"
Write-Host "============================================`n"

# IDE Junk
Remove-Item ".classpath",".factorypath",".project",".pydevproject" -Force -ErrorAction SilentlyContinue
Remove-Item ".settings",".vscode" -Recurse -Force -ErrorAction SilentlyContinue

# Build
Remove-Item "target","bin","dist","build" -Recurse -Force -ErrorAction SilentlyContinue

# Python caches
Get-ChildItem -Recurse -Filter "__pycache__" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# Logs
Remove-Item "*.log" -Force -ErrorAction SilentlyContinue
Remove-Item "python_ai/logs" -Recurse -Force -ErrorAction SilentlyContinue

# JSON
Remove-Item "dashboard_data.json" -Force -ErrorAction SilentlyContinue

Write-Host "`n============================================"
Write-Host "      FINAL DIRECTORY STRUCTURE"
Write-Host "============================================`n"
tree /f

pause
