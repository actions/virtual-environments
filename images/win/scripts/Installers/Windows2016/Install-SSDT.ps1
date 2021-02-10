################################################################################
##  File:  Install-SSDT.ps1
##  Desc:  Install SQL Server Data Tools for Windows
################################################################################

#SSDT for Visual Studio 2017
#The link down below points to the latest version of SSDT for Visual Studio 2017
$InstallerName = "SSDT-Setup-ENU.exe"
$InstallerUrl = "https://go.microsoft.com/fwlink/?linkid=2124518"
$logFilePath = "$env:TEMP\ssdtlog.txt"
$ArgumentList = ("/install", "INSTALLALL", "/passive", "/norestart", "/log `"$logFilePath`"")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList

Write-Host "******** SSDT SETUP LOG START ********"
Write-Host $(Get-Content $logFilePath | Out-String)
Write-Host "******** SSDT SETUP LOG END ********"

Invoke-PesterTests -TestFile "SSDTExtensions"
