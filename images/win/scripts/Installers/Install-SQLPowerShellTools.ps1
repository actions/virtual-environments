################################################################################
##  File:  Install-SQLPowerShellTools.ps1
##  Desc:  Install SQL PowerShell tool
################################################################################

$BaseUrl = "https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64"

# install required MSIs
$SQLSysClrTypesName = "SQLSysClrTypes.msi"
$SQLSysClrTypesUrl = "${BaseUrl}/${SQLSysClrTypesName}"
Install-Binary -Url $SQLSysClrTypesUrl -Name $SQLSysClrTypesName

$SharedManagementObjectsName = "SharedManagementObjects.msi"
$SharedManagementObjectsUrl = "${BaseUrl}/${SharedManagementObjectsName}"
Install-Binary -Url $SharedManagementObjectsUrl -Name $SharedManagementObjectsName

$PowerShellToolsName = "PowerShellTools.msi"
$PowerShellToolsUrl = "${BaseUrl}/${PowerShellToolsName}"
Install-Binary -Url $PowerShellToolsUrl -Name $PowerShellToolsName
