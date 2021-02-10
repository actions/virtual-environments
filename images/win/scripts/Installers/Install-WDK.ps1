################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin19)
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/p/?linkid=2120843"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2128854"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
    $VSver = "2019"
}
else
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/p/?LinkID=2023014"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2026156"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\WDK.vsix"
    $VSver = "2017"
}

$argumentList = ("/features", "+", "/quiet")

# `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
Install-Binary -Url $winSdkUrl -Name "winsdksetup.exe" -ArgumentList $argumentList

# `wdksetup.exe /features + /quiet` installs all features without showing the GUI
Install-Binary -Url $wdkUrl -Name "wdksetup.exe" -ArgumentList $argumentList

# Need to install the VSIX to get the build targets when running VSBuild
Install-VsixExtension -FilePath $FilePath -Name "WDK.vsix" -VSversion $VSver -InstallOnly

Invoke-PesterTests -TestFile "WDK"
