################################################################################
##  File:  Install-Vcpkg.ps1
##  Desc:  Install vcpkg
################################################################################

$Uri = 'https://github.com/Microsoft/vcpkg.git'
$InstallDir = 'C:\vcpkg'
$VcpkgExecPath = 'vcpkg.exe'

git clone --depth=1 $Uri $InstallDir -q

# Build and integrate vcpkg
Invoke-Expression "$InstallDir\bootstrap-vcpkg.bat"
Invoke-Expression "$InstallDir\$VcpkgExecPath integrate install"

# Add vcpkg to system environment
Add-MachinePathItem $InstallDir
$env:Path = Get-MachinePath
setx VCPKG_INSTALLATION_ROOT $InstallDir /M

Invoke-PesterTests -TestFile "Tools" -TestName "Vcpkg"
