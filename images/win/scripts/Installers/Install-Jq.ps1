################################################################################
##  File:  Install-Jq.ps1
##  Desc:  Install jq
################################################################################

Choco-Install -PackageName jq

Invoke-PesterTests -TestFile "Tools" -TestName "Jq"