# RUN WITH THIS
# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\DomainJoin.ps1


# Domain Join Script
# Run PowerShell as Administrator

Set-Location "$env:USERPROFILE\Documents"

# =========================
# User Input
# =========================

$FirstInitial = Read-Host "Enter user's first initial"
$LastName = Read-Host "Enter user's last name"

# Build computer name
$ComputerName = ($FirstInitial + $LastName + "-PC").ToLower()

# Domain info
$DomainName = "USI-SERVER.usiconsultants.com"

# =========================
# Rename Computer
# =========================

Write-Host "Renaming computer to $ComputerName ..." -ForegroundColor Green

Rename-Computer -NewName $ComputerName -Force

# =========================
# Join Domain
# =========================

Write-Host "Joining domain $DomainName ..." -ForegroundColor Green

$Credential = Get-Credential

Add-Computer `
    -DomainName $DomainName `
    -Credential $Credential `
    -Force
