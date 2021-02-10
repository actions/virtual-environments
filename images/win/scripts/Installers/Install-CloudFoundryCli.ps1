################################################################################
##  File:  Install-CloudFoundryCli.ps1
##  Desc:  Install Cloud Foundry CLI
################################################################################

# Download the latest cf cli exe
$CloudFoundryCliName = "cf-cli.zip"
$CloudFoundryCliUrl = "https://packages.cloudfoundry.org/stable?release=windows64-exe&source=github"

$CloudFoundryArchPath = Start-DownloadWithRetry -Url $CloudFoundryCliUrl -Name $CloudFoundryCliName

# Create directory for cf cli
$CloudFoundryCliPath = "C:\cf-cli"
New-Item -Path $CloudFoundryCliPath -ItemType Directory -Force

# Extract the zip archive
Write-Host "Extracting cf cli..."
Extract-7Zip -Path $CloudFoundryArchPath -DestinationPath $CloudFoundryCliPath

# Add cf to path
Add-MachinePathItem $CloudFoundryCliPath

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "CloudFoundry CLI"