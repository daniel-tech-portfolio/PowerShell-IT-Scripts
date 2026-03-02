# PowerShell IT Scripts

A small collection of practical PowerShell scripts that demonstrate common IT support tasks:
- System inventory
- Network troubleshooting info
- Safe temp-file cleanup

## How to run
Open PowerShell and run:

```powershell
# Example (from repo root)
.\scripts\Get-SystemInfo.ps1

# Run and export output
.\scripts\Get-SystemInfo.ps1 | Out-File .\outputs\systeminfo.txt
