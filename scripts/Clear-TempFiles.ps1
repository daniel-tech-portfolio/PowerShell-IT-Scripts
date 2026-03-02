<#
.SYNOPSIS
  Clears current user's temp files safely and logs removed items.
.DESCRIPTION
  Deletes files/folders under $env:TEMP that are not in use.
  Writes a log to .\outputs\temp_cleanup_log.txt when run from repo root.
#>

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
# if script is in .\scripts, repo root is one level up:
$repoRoot = Split-Path -Parent $repoRoot

$outDir = Join-Path $repoRoot "outputs"
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

$logPath = Join-Path $outDir "temp_cleanup_log.txt"
$tempPath = $env:TEMP

"=== Temp Cleanup Run: $(Get-Date) ===" | Out-File -FilePath $logPath -Append
"Temp Path: $tempPath" | Out-File -FilePath $logPath -Append

if (!(Test-Path $tempPath)) {
  "Temp path not found." | Out-File -FilePath $logPath -Append
  Write-Host "Temp path not found."
  exit 1
}

$items = Get-ChildItem -Path $tempPath -Force -ErrorAction SilentlyContinue

$deleted = 0
foreach ($item in $items) {
  try {
    Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
    "Deleted: $($item.FullName)" | Out-File -FilePath $logPath -Append
    $deleted++
  } catch {
    "Skipped (in use / access denied): $($item.FullName)" | Out-File -FilePath $logPath -Append
  }
}

"Deleted count: $deleted" | Out-File -FilePath $logPath -Append
"=== End ===`n" | Out-File -FilePath $logPath -Append

Write-Host "Done. Deleted $deleted item(s). Log: $logPath"
