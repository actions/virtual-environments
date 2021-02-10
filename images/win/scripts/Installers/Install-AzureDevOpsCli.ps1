################################################################################
##  File:  Install-AzureDevOpsCli.ps1
##  Desc:  Install Azure DevOps CLI
################################################################################

az extension add -n azure-devops

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure DevOps CLI"