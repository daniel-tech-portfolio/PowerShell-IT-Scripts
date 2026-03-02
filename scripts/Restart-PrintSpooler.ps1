<#
.SYNOPSIS
  Restarts the Print Spooler service and clears stuck print jobs (optional).
.DESCRIPTION
  Useful for common "printer not printing / stuck queue" tickets.
#>

param(
  [switch]$ClearQueue
)

Write-Host "Restarting Print Spooler..."

try {
  Stop-Service -Name Spooler -Force -ErrorAction Stop
  Start-Sleep -Seconds 2

  if ($ClearQueue) {
    $spoolPath = "$env:SystemRoot\System32\spool\PRINTERS"
    Write-Host "Clearing print queue files in: $spoolPath"
    Get-ChildItem -Path $spoolPath -Force -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
  }

  Start-Service -Name Spooler -ErrorAction Stop
  Write-Host "Print Spooler restarted successfully."
}
catch {
  Write-Host "Failed to restart Print Spooler: $($_.Exception.Message)"
  exit 1
}
