################################################################################
##  File:  Install-zstd.ps1
##  Desc:  Install zstd
################################################################################

Choco-Install -PackageName zstandard

Invoke-PesterTests -TestFile "Tools" -TestName "Zstd"
