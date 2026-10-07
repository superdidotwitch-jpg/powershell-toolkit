# Health report for this laptop
$os = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime

Write-Host "=== Health report ==="
Write-Host "Computer:  $env:COMPUTERNAME"
Write-Host "Windows:   $($os.Caption) build $($os.BuildNumber)"
Write-Host "Checked:   $(Get-Date)"
Write-Host "Uptime:    $($uptime.Days) days, $($uptime.Hours) hours"
Write-Host ""
Write-Host "Drives:"
Get-Volume | Where-Object DriveLetter | Select-Object DriveLetter, @{Name='Label';Expression={$_.FileSystemLabel}}, @{Name='FreeGB';Expression={[math]::Round($_.SizeRemaining/1GB,1)}}, @{Name='SizeGB';Expression={[math]::Round($_.Size/1GB,1)}} | Format-Table
