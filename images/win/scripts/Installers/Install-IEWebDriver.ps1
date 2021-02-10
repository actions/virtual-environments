################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################

try {
    $latestReleaseUrl = "https://selenium-release.storage.googleapis.com/"
    $latestReleaseInfo = Invoke-RestMethod -Uri $latestReleaseUrl
    $latestIEVersion = $latestReleaseInfo.ListBucketResult.Contents | Where-Object Key -match "IEDriverServer_x64" | Sort-Object LastModified | Select-Object -ExpandProperty Key -Last 1
    $ieDriverUrl = -join ($latestReleaseUrl, $latestIEVersion)
} catch {
    Write-Error "[!] Failed to get IEDriver version [$latestReleaseUrl]: $_"
    exit 1
}

# Download IE selenium driver
try {
    Write-Host "Selenium IEDriverServer download and install..."
    $driverZipFile = Start-DownloadWithRetry -Url $ieDriverUrl -Name "SeleniumWebDrivers.zip"
}
catch {
    Write-Error "[!] Failed to download $ieDriverUrl"
    exit 1
}

$ieDriverPath = "C:\SeleniumWebDrivers\IEDriver"
if (-not (Test-Path -Path $ieDriverPath)) {
    $null = New-Item -Path $ieDriverPath -ItemType Directory -Force
}

Extract-7Zip -Path $driverZipFile -DestinationPath $ieDriverPath
Remove-Item $driverZipFile

Write-Host "Get the IEDriver version..."
(Get-Item "$ieDriverPath\IEDriverServer.exe").VersionInfo.FileVersion | Out-File -FilePath "$ieDriverPath\versioninfo.txt"

Write-Host "Setting the IEWebDriver environment variables"
setx IEWebDriver $ieDriverPath /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Internet Explorer"