################################################################################
##  File:  Install-ContainersFeature.ps1
##  Desc:  Install Windows container features.
##         Must be an independent step becuase it requires a machine restart
##         before we can continue.
################################################################################

Write-Host "Install Containers feature"
Install-WindowsFeature -Name Containers

$cpu = (Get-CimInstance -ClassName Win32_Processor)[0]
if ($cpu.VirtualizationFirmwareEnabled -and $cpu.SecondLevelAddressTranslationExtensions) {
  Write-Host "Install Hyper-V feature"
  Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
} else {
  Write-Host "Skipping installation of Hyper-V feature"
}

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "ContainersFeature"