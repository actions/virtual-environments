################################################################################
##  File:  Install-Nuget.ps1
##  Desc:  Install NuGet.CommandLine
################################################################################

Choco-Install -PackageName NuGet.CommandLine

Invoke-PesterTests -TestFile "Tools" -TestName "Nuget"