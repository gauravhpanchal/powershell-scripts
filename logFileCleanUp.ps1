$LogDirectory = "C:\Logs"
$DaysToKeep = 30
$OldLogs = Get-ChildItem -Path $LogDirectory -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$DaysToKeep) }

foreach ($LogFile in $OldLogs) {
    Remove-Item -Path $LogFile.FullName -Force
    Write-Host "Deleted log file: $($LogFile.FullName)"
}
