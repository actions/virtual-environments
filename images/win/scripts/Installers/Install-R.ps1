################################################################################
##  File:  Install-R.ps1
##  Desc:  Install R for Windows
################################################################################

Choco-Install R.Project
Choco-Install rtools

$rscriptPath = Resolve-Path "C:\Program Files\R\*\bin\x64"
Add-MachinePathItem $rscriptPath
Invoke-PesterTests -TestFile "Tools" -TestName "R"