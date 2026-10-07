# Hardening check for this laptop
Write-Host "=== Hardening check ==="

$mp = Get-MpComputerStatus
Write-Host "Real-time protection: $($mp.RealTimeProtectionEnabled)"
Write-Host "Tamper protection:    $($mp.IsTamperProtected)"
Write-Host "Virus definitions:    $($mp.AntivirusSignatureLastUpdated)"

Write-Host ""
Write-Host "Firewall:"
Get-NetFirewallProfile | Select-Object Name, Enabled | Format-Table | Out-Host

$uac = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Write-Host "UAC switched on:      $($uac.EnableLUA -eq 1)"

$last = Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1
Write-Host "Last update:          $($last.HotFixID) on $($last.InstalledOn)"

Write-Host ""
Write-Host "Enabled user accounts:"
Get-LocalUser | Where-Object Enabled | Select-Object Name | Format-Table | Out-Host
