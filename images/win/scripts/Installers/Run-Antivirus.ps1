################################################################################
##  File:  Run-Antivirus.ps1
##  Desc:  Run a full antivirus scan.
##         Run right after cleanup before we sysprep
################################################################################

if ($env:run_scan_antivirus -eq $true) {
    try {
        Update-MpSignature
    }
    catch {
        Write-Host "Some error was found"
        Write-Host $_
    }

    Write-Host "Make sure windefend is going to start"
    Start-Service windefend -ErrorAction Continue
    Write-Host "Waiting for windefend to report as running"
    $service = Get-Service "Windefend"
    $service.WaitForStatus("Running","00:10:00")

    Write-Host "Run antivirus"
    # Tell Defender to use 100% of the CPU during the scan
    Set-MpPreference -ScanAvgCPULoadFactor 100
    # Full Scan
    Start-Process -FilePath "C:\Program Files\Windows Defender\MpCmdRun.exe" -ArgumentList ("-Scan","-ScanType", 2) -Wait
}
else {
    Write-Host "Scanning process has been skipped"
}