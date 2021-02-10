####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

$InstallerName = "AzureCosmosDBEmulator.msi"
$InstallerUrl = "https://aka.ms/cosmosdb-emulator"

Install-Binary -Url $InstallerUrl -Name $InstallerName

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"