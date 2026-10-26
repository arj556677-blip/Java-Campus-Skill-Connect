# ============================================================
# Campus SkillConnect - Build and Deploy Script
# ============================================================

# Auto-detect project folder and tomcat path dynamically
$PROJECT_DIR = $PSScriptRoot
$TOMCAT_HOME = Join-Path $PROJECT_DIR "apache-tomcat-10.1.59"
$APP_URL = "http://localhost:8080/campus-skill-connect/"

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Campus SkillConnect - Build and Deploy"  -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# -- Step 1: Maven CLEAN + PACKAGE -----------------------------
Write-Host "[1/2] Running Maven clean package..." -ForegroundColor Yellow

$buildBat = Join-Path $PROJECT_DIR "build.bat"

# Properly quoted execution for paths with spaces
& "$buildBat"
$buildResult = $LASTEXITCODE

if ($buildResult -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] Maven build FAILED! Fix compilation errors above." -ForegroundColor Red
    exit 1
}

$warFile = Join-Path $PROJECT_DIR "target\campus-skill-connect.war"
if (-not (Test-Path $warFile)) {
    Write-Host "[ERROR] WAR file not found at: $warFile" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Build successful! WAR: campus-skill-connect.war" -ForegroundColor Green

# -- Step 2: Deploy WAR to Tomcat -------------------------------
Write-Host ""
Write-Host "[2/2] Deploying WAR to Tomcat..." -ForegroundColor Yellow

$webapps = Join-Path $TOMCAT_HOME "webapps"
$oldExpanded = Join-Path $webapps "campus-skill-connect"
$oldWar = Join-Path $webapps "campus-skill-connect.war"

# Remove the old expanded webapp folder
if (Test-Path $oldExpanded) {
    Remove-Item -Recurse -Force $oldExpanded -ErrorAction SilentlyContinue
    Write-Host "  - Removed old expanded webapp folder" -ForegroundColor DarkGray
}

# Remove old WAR
if (Test-Path $oldWar) {
    Remove-Item -Force $oldWar -ErrorAction SilentlyContinue
    Write-Host "  - Removed old WAR file" -ForegroundColor DarkGray
}

# Copy fresh WAR
Copy-Item -Path $warFile -Destination $webapps -Force
Write-Host "[OK] Fresh WAR deployed to: $webapps" -ForegroundColor Green

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host " Deployment Complete!"                     -ForegroundColor Yellow
Write-Host " App URL: $APP_URL"                       -ForegroundColor Cyan
Write-Host " Note: Tomcat is NOT auto-started."        -ForegroundColor White
Write-Host " To start:  .\apache-tomcat-10.1.59\bin\startup.bat"  -ForegroundColor Gray
Write-Host " To stop:   .\apache-tomcat-10.1.59\bin\shutdown.bat" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""
