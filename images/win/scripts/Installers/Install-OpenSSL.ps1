################################################################################
##  File:  Install-OpenSSL.ps1
##  Desc:  Install OpenSSL
################################################################################

Choco-Install -PackageName openssl.light

Invoke-PesterTests -TestFile "Tools" -TestName "OpenSSL"