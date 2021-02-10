################################################################################
##  File:  Install-GitVersion.ps1
##  Desc:  Install GitVersion
################################################################################

Choco-Install -PackageName gitversion.portable

Invoke-PesterTests -TestFile "Git" -TestName "GitVersion"
