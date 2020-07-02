################################################################################
##  File:  Install-7zip.ps1
##  Desc:  Install 7zip
################################################################################

Choco-Install -PackageName 7zip.install

Invoke-PesterTests -TestFile "Common" -TestName "7-Zip"