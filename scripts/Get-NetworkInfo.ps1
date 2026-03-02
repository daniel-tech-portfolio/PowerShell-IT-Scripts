<#
.SYNOPSIS
  Quick network diagnostics: adapter/IP info + DNS + ping tests.
#>

Write-Host "=== Network Adapters (Up) ==="
Get-NetAdapter | Where-Object Status -eq "Up" |
  Select-Object Name, InterfaceDescription, LinkSpeed, MacAddress |
  Format-Table -AutoSize

Write-Host "`n=== IP Configuration ==="
Get-NetIPConfiguration |
  Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer |
  Format-List

# Determine default gateway
$gw = (Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null} |
      Select-Object -First 1).IPv4DefaultGateway.NextHop

Write-Host "`n=== Connectivity Tests ==="

if ($gw) {
  Write-Host "Ping default gateway: $gw"
  Test-Connection -ComputerName $gw -Count 2 -Quiet | ForEach-Object {
    Write-Host ("Result: " + (if($_){"Success"}else{"Fail"}))
  }
} else {
  Write-Host "No default gateway detected."
}

$publicIP = "8.8.8.8"
Write-Host "`nPing public DNS IP: $publicIP"
Test-Connection -ComputerName $publicIP -Count 2 -Quiet | ForEach-Object {
  Write-Host ("Result: " + (if($_){"Success"}else{"Fail"}))
}

$dnsName = "google.com"
Write-Host "`nDNS resolution test: $dnsName"
try {
  Resolve-DnsName $dnsName -ErrorAction Stop | Select-Object -First 3 Name, IPAddress | Format-Table -AutoSize
} catch {
  Write-Host "DNS resolution failed: $($_.Exception.Message)"
}
