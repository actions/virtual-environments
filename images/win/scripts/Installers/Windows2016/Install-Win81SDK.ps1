################################################################################
##  File:  Install-Win81SDK.ps1
##  Desc:  Install Windows 8.1 SDK
################################################################################

$InstallerName = "sdksetup.exe"
$InstallerUrl = "http://download.microsoft.com/download/B/0/C/B0C80BA3-8AD6-4958-810B-6882485230B5/standalonesdk/${InstallerName}"
$ArgumentList = ("/quiet", "/norestart")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
