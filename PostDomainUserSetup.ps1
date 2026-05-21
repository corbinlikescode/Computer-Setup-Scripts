# cd $env:USERPROFILE\Documents
# Set-ExecutionPolicy Bypass -Scope Process
# .\PostDomainUserSetup.ps1

Set-Location "$env:USERPROFILE\Documents"

Write-Host "Starting Phase 6 - Post-Domain User Setup..." -ForegroundColor Green

# =========================
# Add domain user as local admin
# =========================

$Username = Read-Host "Enter domain username example: cmurray"

# Try common domain formats
$DomainUser1 = "USI-SERVER\$Username"
$DomainUser2 = "$Username@usiconsultants.com"

Write-Host "Attempting to add $DomainUser1 as local administrator..." -ForegroundColor Yellow

try {
    Add-LocalGroupMember -Group "Administrators" -Member $DomainUser1 -ErrorAction Stop
    Write-Host "$DomainUser1 added as local administrator." -ForegroundColor Green
}
catch {
    Write-Host "First format failed. Trying $DomainUser2 ..." -ForegroundColor Yellow

    try {
        Add-LocalGroupMember -Group "Administrators" -Member $DomainUser2 -ErrorAction Stop
        Write-Host "$DomainUser2 added as local administrator." -ForegroundColor Green
    }
    catch {
        Write-Host "Could not add user as local admin." -ForegroundColor Red
        Write-Host "Check username format, domain connection, and whether the user exists in Active Directory." -ForegroundColor Red
    }
}

# =========================
# Create Microsoft 365 desktop shortcuts
# =========================

Write-Host "Creating Microsoft 365 desktop shortcuts..." -ForegroundColor Green

$PublicDesktop = "C:\Users\Public\Desktop"

$OfficeShortcuts = @(
    @{
        Name = "Outlook"
        Path = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
    },
    @{
        Name = "Word"
        Path = "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"
    },
    @{
        Name = "Excel"
        Path = "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
    },
    @{
        Name = "PowerPoint"
        Path = "C:\Program Files\Microsoft Office\root\Office16\POWERPNT.EXE"
    },
    @{
        Name = "OneDrive"
        Path = "C:\Program Files\Microsoft OneDrive\OneDrive.exe"
    }
)

$Shell = New-Object -ComObject WScript.Shell

foreach ($App in $OfficeShortcuts) {
    if (Test-Path $App.Path) {
        $Shortcut = $Shell.CreateShortcut("$PublicDesktop\$($App.Name).lnk")
        $Shortcut.TargetPath = $App.Path
        $Shortcut.Save()

        Write-Host "$($App.Name) shortcut created." -ForegroundColor Green
    }
    else {
        Write-Host "$($App.Name) not found. Shortcut skipped." -ForegroundColor Yellow
    }
}

# =========================
# User login and licensing reminders
# =========================

Write-Host ""
Write-Host "Manual checks still required:" -ForegroundColor Yellow
Write-Host "1. Confirm the domain user can log in."
Write-Host "2. Have the user sign into Microsoft 365 if needed."
Write-Host "3. Confirm Adobe opens and licensing is active."
Write-Host "4. Confirm MFA/login prompts are completed."
Write-Host ""

Write-Host "Phase 6 completed." -ForegroundColor Green