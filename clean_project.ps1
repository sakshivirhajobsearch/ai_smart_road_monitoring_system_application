Write-Host "============================================================"
Write-Host "     CLEANING PROJECT (PowerShell Cleaner)"
Write-Host "============================================================`n"

# -------- Delete IDE Junk --------
Write-Host "Deleting IDE junk..."
Remove-Item -Force -ErrorAction SilentlyContinue .classpath
Remove-Item -Force -ErrorAction SilentlyContinue .project
Remove-Item -Force -ErrorAction SilentlyContinue .factorypath
Remove-Item -Force -ErrorAction SilentlyContinue .pydevproject

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue ".settings"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue ".vscode"

# -------- Delete Build Folders --------
Write-Host "Deleting build folders..."
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "target"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "build"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "dist"

# -------- Delete Python Cache --------
Write-Host "Deleting Python cache..."
Get-ChildItem -Recurse -Force -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# -------- Delete logs --------
Write-Host "Deleting logs..."
Get-ChildItem -Recurse -Force -Filter "*.log" | Remove-Item -Force -ErrorAction SilentlyContinue

# -------- Delete duplicate folders under bin --------
Write-Host "Removing duplicate content under /bin..."
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin\database"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin\data"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin\docs"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin\python_ai"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "bin\scripts"

# -------- Delete compiled *.class --------
Write-Host "Removing compiled Java *.class files..."
Get-ChildItem -Recurse -Force -Filter "*.class" | Remove-Item -Force -ErrorAction SilentlyContinue

# -------- Output Final Directory Structure --------
Write-Host "`n============================================================"
Write-Host "           FINAL DIRECTORY STRUCTURE"
Write-Host "============================================================`n"

tree /f

Write-Host "`nCleanup complete."
pause
exit
