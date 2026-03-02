```powershell
<#
.SYNOPSIS
  Collects basic system inventory info for IT support.
#>

$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$cs  = Get-CimInstance Win32_ComputerSystem

# Uptime
$lastBoot = [Management.ManagementDateTimeConverter]::ToDateTime($os.LastBootUpTime)
$uptime   = (Get-Date) - $lastBoot

# Disk summary
$disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
    Select-Object DeviceID,
                  @{n="SizeGB";e={[math]::Round($_.Size/1GB,2)}},
                  @{n="FreeGB";e={[math]::Round($_.FreeSpace/1GB,2)}}

[PSCustomObject]@{
  ComputerName = $env:COMPUTERNAME
  UserName     = $env:USERNAME
  OS           = "$($os.Caption) ($($os.Version))"
  LastBoot     = $lastBoot
  Uptime       = ("{0}d {1}h {2}m" -f $uptime.Days, $uptime.Hours, $uptime.Minutes)
  CPU          = $cpu.Name
  RAM_GB       = [math]::Round($cs.TotalPhysicalMemory/1GB,2)
} | Format-List

"Disk Summary:"
$disks | Format-Table -AutoSize
