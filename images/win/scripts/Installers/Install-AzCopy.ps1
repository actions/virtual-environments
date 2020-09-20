################################################################################
##  File:  Install-AzCopy.ps1
##  Desc:  Install AzCopy10
################################################################################

Choco-Install -PackageName azcopy10

Invoke-PesterTests -TestFile "Tools" -TestName "AzCopy"