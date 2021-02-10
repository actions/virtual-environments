################################################################################
##  File:  Install-InnoSetup.ps1
##  Desc:  Install Inno Setup
################################################################################

Choco-Install -PackageName innosetup

Invoke-PesterTests -TestFile "Tools" -TestName "InnoSetup"