################################################################################
##  File:  run-tests.ps1
##  Desc:  run all pester tests
################################################################################

Get-ChildItem  | % {  & $_.FullName } 