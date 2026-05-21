# Run with:
# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\TestInstall.ps1

# Small Software Install Test Script
# Run PowerShell as Administrator

Set-Location "$env:USERPROFILE\Documents"

# Installer Paths
$GoogleEarthInstaller = "Y:\Software Updates\Google Earth\GoogleEarthProSetup.exe"
$SplashtopInstaller = "Y:\Systems Software\Splashtop\SplashtopSOS-USI_Custom.exe"
$SophosInstaller = "Y:\Sophos\SophosSetup.exe"
$WatchGuardEndpointInstaller = "Y:\Systems Software\watchguard\WatchGuard Agent.msi"
$WatchGuardVPNInstaller = "Y:\Systems Software\watchguard\WG-Mobile-VPN_Windows_x86-64_1514_29669.exe"
$AdobeInstaller = "Y:\Programs\z_Acrobat_Pro_2024.exe"

Write-Host "Starting test installs..." -ForegroundColor Green

# Install Google Chrome using winget
Write-Host "Installing Google Chrome..."
winget install --id Google.Chrome -e --silent --accept-package-agreements --accept-source-agreements

# Install Google Earth Pro
Write-Host "Installing Google Earth Pro..."
Start-Process -FilePath $GoogleEarthInstaller -ArgumentList "/silent" -Wait

# Install Splashtop
Write-Host "Installing Splashtop..."
Start-Process -FilePath $SplashtopInstaller -ArgumentList "/silent" -Wait

# Install Sophos
Write-Host "Installing Sophos..."
Start-Process -FilePath $SophosInstaller -ArgumentList "--quiet" -Wait

# Install WatchGuard Endpoint
Write-Host "Installing WatchGuard Endpoint..."
Start-Process "msiexec.exe" -ArgumentList "/i `"$WatchGuardEndpointInstaller`" /qn /norestart" -Wait

# Install WatchGuard VPN
Write-Host "Installing WatchGuard VPN..."
Start-Process -FilePath $WatchGuardVPNInstaller -ArgumentList "/silent" -Wait

# Install Adobe Acrobat Pro
Write-Host "Installing Adobe Acrobat Pro..."
Start-Process -FilePath $AdobeInstaller -ArgumentList "/silent" -Wait

Write-Host "Test installs completed." -ForegroundColor Green