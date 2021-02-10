################################################################################
##  File:  Install-Cmake.ps1
##  Desc:  Install Cmake
################################################################################

Choco-Install -PackageName cmake.install -ArgumentList "--installargs",'ADD_CMAKE_TO_PATH=""System""'

Invoke-PesterTests -TestFile "Tools" -TestName "CMake"