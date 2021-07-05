################################################################################
##  File:  Install-Aria2.ps1
##  Desc:  Install Aria2
################################################################################

Choco-Install -PackageName aria2

Invoke-PesterTests -TestFile "Tools" -TestName "Aria2"
