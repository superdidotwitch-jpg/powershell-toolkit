# Clean temporary files older than 7 days
$folder = $env:TEMP
$cutoff = (Get-Date).AddDays(-7)
$old = Get-ChildItem $folder -Recurse -File -ErrorAction SilentlyContinue | Where-Object LastWriteTime -lt $cutoff
$sizeMB = [math]::Round(($old | Measure-Object Length -Sum).Sum / 1MB, 1)

Write-Host "=== Temp cleanup ==="
Write-Host "Folder:        $folder"
Write-Host "Old files:     $($old.Count)"
Write-Host "Space to free: $sizeMB MB"

$answer = Read-Host "Delete these files? Type Y for yes"
if ($answer -eq "Y") {
    $old | Remove-Item -Force -ErrorAction SilentlyContinue
    Write-Host "Done. Files in use were skipped."
} else {
    Write-Host "Nothing deleted."
}
