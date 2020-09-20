param(
    [String] [Parameter (Mandatory=$true)] $Image,
    [String] [Parameter (Mandatory=$true)] $ResourcesNamePrefix,
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$true)] $ClientSecret,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $TenantId
)

az login --service-principal --username $ClientId --password $ClientSecret --tenant $TenantId | Out-Null

$TempResourceGroupName = "${ResourcesNamePrefix}_${Image}"

$groupExist = az group exists --name $TempResourceGroupName --subscription $SubscriptionId
if ($groupExist -eq "true") {
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --subscription $SubscriptionId --yes | Out-Null
    Write-Host "Temporary group was deleted succesfully" -ForegroundColor Green
} else {
    Write-Host "No temporary groups found"
}