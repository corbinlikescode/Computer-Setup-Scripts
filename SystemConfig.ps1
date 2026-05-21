# RUN THIS (MUST OPEM POWERSHELL AS ADMIN)
# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\SystemConfig.ps1

# System Configuration Script
# Run PowerShell as Administrator

Set-Location "$env:USERPROFILE\Documents"

Write-Host "Starting system configuration..." -ForegroundColor Green

# =========================
# Lid close behavior
# =========================

Write-Host "Setting lid close action to Do Nothing..."

powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setactive SCHEME_CURRENT

# =========================
# Time zone
# =========================

Write-Host "Setting time zone..."

Set-TimeZone -Id "Eastern Standard Time"

# =========================
# Disable Windows Error Reporting
# =========================

Write-Host "Disabling Windows Error Reporting..."

Stop-Service WerSvc -ErrorAction SilentlyContinue
Set-Service WerSvc -StartupType Disabled

# =========================
# Enable .NET Framework 3.5
# =========================

Write-Host "Enabling .NET Framework 3.5..."

Enable-WindowsOptionalFeature `
    -Online `
    -FeatureName NetFx3 `
    -All `
    -NoRestart

# =========================
# Disable Windows Subsystem for Linux
# =========================

Write-Host "Disabling Windows Subsystem for Linux..."

Disable-WindowsOptionalFeature `
    -Online `
    -FeatureName Microsoft-Windows-Subsystem-Linux `
    -NoRestart

# =========================
# Map Y Drive
# =========================

Write-Host "Mapping Y: drive..."

if (!(Get-PSDrive -Name "Y" -ErrorAction SilentlyContinue)) {

    New-PSDrive `
        -Name "Y" `
        -PSProvider FileSystem `
        -Root "\\data5\Downloads" `
        -Persist
}

Write-Host "System configuration completed." -ForegroundColor Green