################################################################################
##  File:  Install-Svn.ps1
##  Desc:  Install Subversion
################################################################################

Choco-Install -PackageName tortoisesvn

Invoke-PesterTests -TestFile "Tools" -TestName "Svn"
