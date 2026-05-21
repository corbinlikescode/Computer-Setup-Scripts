# Computer Setup Scripts

PowerShell scripts used to break the new-computer setup process into smaller phases. These scripts help automate computer identity, system configuration, software installation, printer setup, domain joining, and post-domain user setup.

## Scripts

| Script | Purpose |
|---|---|
| `ComputerIdentity.ps1` | Renames the computer using the company naming format. |
| `SystemConfig.ps1` | Applies local Windows settings such as time zone, lid close behavior, .NET Framework, WSL, and Windows Error Reporting. |
| `ProgramInstall.ps1` | Installs common software from company file paths. |
| `PrinterScript.ps1` | Installs printer/plotter drivers, creates printer ports, and adds printers. |
| `DomainJoin.ps1` | Joins the computer to the company domain. |
| `PostDomainUserSetup.ps1` | Adds the domain user as a local admin and creates Microsoft 365 desktop shortcuts. |

## Requirements

- Run scripts in PowerShell as Administrator.
- Computer must have access to required network paths.
- Some scripts require the computer to be connected to the company network.
- Printer driver folders must be available locally before running the printer script.
- Domain join requires valid domain administrator credentials.

## Basic Run Command

Open PowerShell as Administrator and run:

```powershell
cd $env:USERPROFILE\Documents
Set-ExecutionPolicy Bypass -Scope Process
.\ScriptName.ps1
