# PowerShell Scripts for IT Support

This repository contains PowerShell scripts designed to assist IT support technicians and system administrators with common troubleshooting and maintenance tasks.

The scripts demonstrate basic automation techniques used in Windows environments.

---

# Scripts Included

## Get-SystemInfo.ps1

Collects useful system information that can assist with troubleshooting.

Example information gathered:

- Hostname
- Operating system version
- Installed memory
- IP configuration
- Network adapter details

Example use case:

Helpdesk technicians often need system information when diagnosing user issues. This script quickly gathers important details and exports them for review.

Example command:
.\Get-SystemInfo.ps1


---

## Network Troubleshooting Script

Collects network diagnostic information to help identify connectivity problems.

Information gathered may include:

- IP configuration
- DNS servers
- Gateway information
- Network adapter status

Example use case:

Used when diagnosing network connectivity issues reported by users.

---

## Temp File Cleanup Script

Removes temporary files to free disk space and improve system performance.

Use case:

Common maintenance task performed by IT support technicians during troubleshooting.

---

# Requirements

PowerShell execution policy may need to allow script execution.

Example command:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


---

# Purpose of this Repository

This project demonstrates:

- Basic PowerShell scripting
- Windows system administration tasks
- Troubleshooting automation
- IT support workflow improvements

---

# Disclaimer

These scripts are intended for educational and demonstration purposes. Always review scripts before running them in production environments.

---

# Related Project

IT Helpdesk Cheat Sheets

https://github.com/daniel-tech-portfolio/IT-Helpdesk-CheatSheets
