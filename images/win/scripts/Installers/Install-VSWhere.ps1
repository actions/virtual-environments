################################################################################
##  File:  Install-VSWhere.ps1
##  Desc:  Install latest stable version of VSWhere
################################################################################

Choco-Install -PackageName vswhere

Invoke-PesterTests -TestFile "Tools" -TestName "VSWhere"
