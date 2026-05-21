# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\ComputerIdentity.ps1


Set-Location "$env:USERPROFILE\Documents"

# Ask for naming info
$FirstInitial = Read-Host "Enter user's first initial"
$LastName = Read-Host "Enter user's last name"

# Build computer name
$ComputerName = ($FirstInitial + $LastName + "-PC").ToLower()

Write-Host "Computer will be renamed to $ComputerName" -ForegroundColor Green

# Rename computer
Rename-Computer -NewName $ComputerName -Force

Write-Host "Computer renamed successfully." -ForegroundColor Green
Write-Host "Restarting computer..." -ForegroundColor Yellow

Restart-Computer -Force