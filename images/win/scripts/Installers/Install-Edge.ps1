################################################################################
##  File:  Install-Edge.ps1
##  Desc:  Install latest stable version of Microsoft Edge browser
################################################################################

Choco-Install -PackageName microsoft-edge

# Install Microsoft Edge WebDriver
Write-Host "Install Edge WebDriver..."
$EdgeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $EdgeDriverPath))
{
    New-Item -Path $EdgeDriverPath -ItemType Directory -Force
}

Write-Host "Get the Microsoft Edge WebDriver version..."
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$EdgePath = (Get-ItemProperty "$RegistryPath\msedge.exe").'(default)'
[version]$EdgeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($EdgePath).ProductVersion
$EdgeDriverVersionUrl = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($EdgeVersion.Major)"

$EdgeDriverVersionFile = Start-DownloadWithRetry -Url $EdgeDriverVersionUrl -Name "versioninfo.txt" -DownloadPath $EdgeDriverPath

Write-Host "Download Microsoft Edge WebDriver..."
$EdgeDriverLatestVersion = Get-Content -Path $EdgeDriverVersionFile
$EdgeDriverArchName = "edgedriver_win64.zip"
# A temporary workaround to install the previous driver version because 85.0.564.60 for win64 doesn't exist
if ($EdgeDriverLatestVersion -eq "85.0.564.60")
{
    $EdgeDriverLatestVersion = "85.0.564.51"
    Set-Content -Path $EdgeDriverVersionFile -Value $EdgeDriverLatestVersion
}

$EdgeDriverDownloadUrl = "https://msedgedriver.azureedge.net/${EdgeDriverLatestVersion}/${EdgeDriverArchName}"

$EdgeDriverArchPath = Start-DownloadWithRetry -Url $EdgeDriverDownloadUrl -Name $EdgeDriverArchName

Write-Host "Expand Microsoft Edge WebDriver archive..."
Extract-7Zip -Path $EdgeDriverArchPath -DestinationPath $EdgeDriverPath

Write-Host "Setting the environment variables..."
setx EdgeWebDriver "$EdgeDriverPath" /M

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$EdgeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Edge"