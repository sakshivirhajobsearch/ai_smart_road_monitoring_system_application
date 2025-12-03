Write-Host ""
Write-Host "============================================================"
Write-Host "           CLEANING PROJECT (PowerShell Script)"
Write-Host "============================================================"
Write-Host ""

# --------------------------
# 1. Remove IDE metadata
# --------------------------
Write-Host "[1] Removing IDE metadata..."

$ideFolders = @(".idea", ".vscode", ".classpath", ".project", ".settings")

foreach ($folder in $ideFolders) {
    if (Test-Path $folder) {
        Write-Host "   - deleting $folder"
        Remove-Item -Recurse -Force $folder -ErrorAction SilentlyContinue
    }
}

# --------------------------
# 2. Remove Maven build folders
# --------------------------
Write-Host "[2] Removing build folders..."

if (Test-Path "target") {
    Write-Host "   - deleting /target"
    Remove-Item -Recurse -Force "target" -ErrorAction SilentlyContinue
}

# --------------------------
# 3. Remove Python cache
# --------------------------
Write-Host "[3] Removing Python __pycache__..."

Get-ChildItem -Path "python_ai" -Recurse -Directory -Filter "__pycache__" |
ForEach-Object {
    Write-Host "   - deleting $($_.FullName)"
    Remove-Item -Recurse -Force $_.FullName -ErrorAction SilentlyContinue
}

# --------------------------
# 4. Remove logs
# --------------------------
Write-Host "[4] Removing logs..."

Get-ChildItem -Recurse -Filter *.log |
ForEach-Object {
    Write-Host "   - deleting $($_.FullName)"
    Remove-Item -Force $_.FullName -ErrorAction SilentlyContinue
}

# --------------------------
# 5. Remove auto-generated JSON data
# --------------------------
Write-Host "[5] Removing auto-generated JSON data..."

$dummyJsonFiles = @(
    "potholes_data.json",
    "road_data.json",
    "python_ai\data\dummy_pothole_data.json",
    "python_ai\data\dummy_road_data.json"
)

foreach ($file in $dummyJsonFiles) {
    if (Test-Path $file) {
        Write-Host "   - deleting $file"
        Remove-Item -Force $file -ErrorAction SilentlyContinue
    }
}

# --------------------------
# 6. Cleaning Uploads Folder
# --------------------------
Write-Host "[6] Cleaning Python uploads..."

# Clean images
Get-ChildItem -Recurse -Path "python_ai\uploads\images" -Include *.jpg, *.jpeg, *.png, *.csv |
ForEach-Object {
    Write-Host "   - deleting uploaded file $($_.FullName)"
    Remove-Item -Force $_.FullName -ErrorAction SilentlyContinue
}

# Clean sensor files
Get-ChildItem -Recurse -Path "python_ai\uploads\sensor" -Include *.csv, *.xlsx |
ForEach-Object {
    Write-Host "   - deleting sensor file $($_.FullName)"
    Remove-Item -Force $_.FullName -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "============================================================"
Write-Host "              FINAL DIRECTORY STRUCTURE"
Write-Host "============================================================"
tree /f /a
Write-Host "============================================================"
Write-Host "                 CLEAN COMPLETE ✔"
Write-Host "============================================================"

Pause
