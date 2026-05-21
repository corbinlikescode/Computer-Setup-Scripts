# Computer Setup Scripts

PowerShell scripts used to break the new-computer setup process into smaller phases. These scripts help automate computer identity, system configuration, software installation, printer setup, domain joining, and post-domain user setup.

## Repository Scripts

| Script | Purpose |
|---|---|
| `SystemConfig.ps1` | Applies local Windows settings such as time zone, lid close behavior, .NET Framework, WSL settings, and Windows Error Reporting. |
| `ComputerIdentity.ps1` | Renames the computer using the company naming format. |
| `ProgramInstall.ps1` | Installs common company software from known installer paths. |
| `PrinterScript.ps1` | Installs printer and plotter drivers, creates TCP/IP ports, and adds printers. |
| `DomainJoin.ps1` | Joins the computer to the company domain. |
| `PostDomainUserSetup.ps1` | Adds the domain user as a local administrator and creates Microsoft 365 desktop shortcuts. |
| `UpdatesSecurity.ps1` | Runs Windows updates, checks Dell Command Update, verifies BitLocker status, and confirms security services such as Sophos and WatchGuard are installed and running. |

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
