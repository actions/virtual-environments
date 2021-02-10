###################################################################################
##  File:  Install-Vsix.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

$toolset = Get-ToolsetContent
$vsixPackagesList = $toolset.visualStudio.vsix
if (-not $vsixPackagesList) {
    Write-Host "No extensions to install"
    exit 0
}

$vsVersion = $toolset.visualStudio.Version
$vsixPackagesList | ForEach-Object {
    Install-VsixExtension -Url $_.url -Name $_.name -VSversion $vsVersion
}

Invoke-PesterTests -TestFile "Vsix"