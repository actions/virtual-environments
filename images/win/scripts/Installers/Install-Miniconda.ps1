################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
################################################################################

$CondaDestination = "C:\Miniconda"

# Install the latest Miniconda
$InstallerName = "Miniconda3-latest-Windows-x86_64.exe"
$InstallerUrl = "https://repo.continuum.io/miniconda/${InstallerName}"
$ArgumentList = ("/S", "/AddToPath=0", "/RegisterPython=0", "/D=$CondaDestination")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
Set-SystemVariable -SystemVariable "CONDA" -Value $CondaDestination

Invoke-PesterTests -TestFile "Miniconda"