################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
################################################################################

Import-Module -Name ImageHelpers -Force

$CondaDestination = "C:\Miniconda"

# Lock to Miniconda 4.6 until we do the work to run `conda init` for the vsts user
# Then we can go back to installing the latest Miniconda
# $url = "https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe"
$InstallerName = "Miniconda3-4.6.14-Windows-x86_64.exe"
$InstallerUrl = "https://repo.continuum.io/miniconda/${InstallerName}"
$ArgumentList = ("/S", "/AddToPath=0", "/RegisterPython=0", "/D=$CondaDestination")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
Set-SystemVariable -SystemVariable "CONDA" -Value $CondaDestination

Invoke-PesterTests -TestFile "Miniconda"