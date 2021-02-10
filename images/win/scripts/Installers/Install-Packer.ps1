################################################################################
##  File:  Install-Packer.ps1
##  Desc:  Install Packer
################################################################################

Choco-Install -PackageName packer

Invoke-PesterTests -TestFile "Tools" -TestName "Packer"