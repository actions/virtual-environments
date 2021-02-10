################################################################################
##  File:  Install-Pulumi.ps1
##  Desc:  Install Pulumi
################################################################################

Choco-Install -PackageName pulumi

Invoke-PesterTests -TestFile "Tools" -TestName "Pulumi"