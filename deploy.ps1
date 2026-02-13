Write-Host "Starting Clean Flutter Web Build..." -ForegroundColor Green
flutter build web --release --pwa-strategy=none
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit
}

Write-Host "Cleaning public directory..." -ForegroundColor Yellow
if (Test-Path "public") {
    Remove-Item -Recurse -Force "public"
}

Write-Host "Moving build files..." -ForegroundColor Yellow
Move-Item "build\web" "public"

if (Test-Path "public\flutter_service_worker.js") {
    Remove-Item "public\flutter_service_worker.js"
}

Write-Host "Deploying to GitHub..." -ForegroundColor Cyan
git add .
git commit -m "Auto-deploy clean build (No Service Worker)"
git push origin main

Write-Host "Deployment Complete! ✅" -ForegroundColor Green
