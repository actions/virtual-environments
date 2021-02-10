Write-Host "Set antivirus parameters"
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "D:\", "C:\"