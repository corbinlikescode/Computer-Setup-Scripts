# Printer Install Test Script
# Run PowerShell as Administrator

$Desktop = "$env:USERPROFILE\Desktop"

# Update these filenames to match the exact files on your Desktop
$ToshibaINF = "$Desktop\64bit\f24c79fd-769a-4c8d-a558-d49fef699239.inf"
$PlotterINF = "$Desktop\ps3\bd2ce88c-b0bf-4e46-861d-c302fe82c7b1.inf"

# Driver names from the INF files
$ToshibaDriver = "TOSHIBA Universal Printer 2"
$HPDriver = "HP DesignJet PS3"

# Install drivers
pnputil /add-driver "$ToshibaINF" /install
pnputil /add-driver "$PlotterINF" /install

Add-PrinterDriver -Name $ToshibaDriver
Add-PrinterDriver -Name $HPDriver

# Create printer ports
Add-PrinterPort -Name "IP_192.168.2.224" -PrinterHostAddress "192.168.2.224"
Add-PrinterPort -Name "IP_192.168.2.225" -PrinterHostAddress "192.168.2.225"
Add-PrinterPort -Name "IP_192.168.2.215" -PrinterHostAddress "192.168.2.215"

# Add printers
Add-Printer -Name "Toshiba 6516AC" -DriverName $ToshibaDriver -PortName "IP_192.168.2.224"
Add-Printer -Name "Toshiba 4515AC" -DriverName $ToshibaDriver -PortName "IP_192.168.2.225"
Add-Printer -Name "HP DesignJet XL 3800" -DriverName $HPDriver -PortName "IP_192.168.2.215"

Write-Host "Printers added. Test print manually." -ForegroundColor Green