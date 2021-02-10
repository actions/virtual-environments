################################################################################
##  File:  Install-AzureDevSpacesCLI.ps1
##  Desc:  Install Azure Dev Spaces CLI
################################################################################

# Install Azure Dev Spaces CLI
Install-Binary -Url "https://aka.ms/get-azds-windows" -Name "Azure Dev Spaces CLI.exe" -ArgumentList ("/quiet")
Add-MachinePathItem -PathItem "C:\Program Files\Microsoft SDKs\Azure\Azure Dev Spaces CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure Dev Spaces CLI"