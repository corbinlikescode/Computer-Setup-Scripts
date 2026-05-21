# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\UpdatesSecurity.ps1

Set-Location "$env:USERPROFILE\Documents"

Write-Host "Starting Phase 8 - Updates and Security..." -ForegroundColor Green

# =========================
# Windows Updates
# =========================

Write-Host "Checking for Windows Updates..." -ForegroundColor Green

Install-Module PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate

Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot

# =========================
# Dell Updates
# =========================

Write-Host "Checking for Dell Command Update..." -ForegroundColor Green

$DellCommandPaths = @(
    "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe",
    "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
)

$DellCommand = $DellCommandPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

if ($DellCommand) {
    Write-Host "Running Dell Command Update..." -ForegroundColor Green
    Start-Process -FilePath $DellCommand -ArgumentList "/applyUpdates -silent -reboot=disable" -Wait
}
else {
    Write-Host "Dell Command Update was not found. Install or run manually." -ForegroundColor Yellow
}

# =========================
# BitLocker Status
# =========================

Write-Host "Checking BitLocker status..." -ForegroundColor Green

$BitLockerStatus = Get-BitLockerVolume -MountPoint "C:"

if ($BitLockerStatus.ProtectionStatus -eq "On") {
    Write-Host "BitLocker is already enabled." -ForegroundColor Green
}
else {
    Write-Host "BitLocker is not enabled." -ForegroundColor Yellow
    Write-Host "Enable BitLocker manually after confirming recovery key storage policy." -ForegroundColor Yellow
}

# =========================
# Endpoint Protection Checks
# =========================

Write-Host "Checking Sophos service..." -ForegroundColor Green
Get-Service | Where-Object { $_.DisplayName -like "*Sophos*" } | Select-Object DisplayName, Status

Write-Host "Checking WatchGuard service..." -ForegroundColor Green
Get-Service | Where-Object { $_.DisplayName -like "*WatchGuard*" } | Select-Object DisplayName, Status

Write-Host "Phase 8 completed. Restart recommended." -ForegroundColor Green