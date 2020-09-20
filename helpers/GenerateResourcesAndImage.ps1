$ErrorActionPreference = 'Stop'

enum ImageType {
    Windows2016 = 0
    Windows2019 = 1
    Ubuntu1604 = 2
    Ubuntu1804 = 3
    Ubuntu2004 = 4
}

Function Get-PackerTemplatePath {
    param (
        [Parameter(Mandatory = $True)]
        [string] $RepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType
    )

    $relativePath = "N/A"

    switch ($ImageType) {
        ([ImageType]::Windows2016) {
            $relativePath = "\images\win\Windows2016-Azure.json"
        }
        ([ImageType]::Windows2019) {
            $relativePath = "\images\win\Windows2019-Azure.json"
        }
        ([ImageType]::Ubuntu1604) {
            $relativePath = "\images\linux\ubuntu1604.json"
        }
        ([ImageType]::Ubuntu1804) {
            $relativePath = "\images\linux\ubuntu1804.json"
        }
        ([ImageType]::Ubuntu2004) {
            $relativePath = "\images\linux\ubuntu2004.json"
        }
    }

    return $RepositoryRoot + $relativePath;
}

Function Get-LatestCommit {
    [CmdletBinding()]
    param()

    process {
        Write-Host "Latest commit:"
        git log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1
    }
}

Function GenerateResourcesAndImage {
    <#
        .SYNOPSIS
            A helper function to help generate an image.

        .DESCRIPTION
            Creates Azure resources and kicks off a packer image generation for the selected image type.

        .PARAMETER SubscriptionId
            The Azure subscription Id where resources will be created.

        .PARAMETER ResourceGroupName
            The Azure resource group name where the Azure resources will be created.

        .PARAMETER ImageGenerationRepositoryRoot
            The root path of the image generation repository source.

        .PARAMETER ImageType
            The type of the image being generated. Valid options are: {"Windows2016", "Windows2019", "Ubuntu1604", "Ubuntu1804"}.

        .PARAMETER AzureLocation
            The location of the resources being created in Azure. For example "East US".

        .PARAMETER Force
            Delete the resource group if it exists without user confirmation.

        .PARAMETER GithubFeedToken
            GitHub PAT to download tool packages from GitHub Package Registry

        .EXAMPLE
            GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "shsamytest1" -ImageGenerationRepositoryRoot "C:\virtual-environments" -ImageType Ubuntu1604 -AzureLocation "East US"
    #>
    param (
        [Parameter(Mandatory = $True)]
        [string] $SubscriptionId,
        [Parameter(Mandatory = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True)]
        [string] $ImageGenerationRepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType,
        [Parameter(Mandatory = $True)]
        [string] $AzureLocation,
        [Parameter(Mandatory = $False)]
        [int] $SecondsToWaitForServicePrincipalSetup = 30,
        [Parameter(Mandatory = $False)]
        [string] $GithubFeedToken,
        [Parameter(Mandatory = $False)]
        [Switch] $Force
    )

    if (([string]::IsNullOrEmpty($GithubFeedToken)))
    {
        Write-Error "'-GithubFeedToken' parameter is not specified. You have to specify valid GitHub PAT to download tool packages from GitHub Package Registry"
        exit 1
    }

    $builderScriptPath = Get-PackerTemplatePath -RepositoryRoot $ImageGenerationRepositoryRoot -ImageType $ImageType
    $ServicePrincipalClientSecret = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper();
    $InstallPassword = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper();

    Login-AzureRmAccount
    Set-AzureRmContext -SubscriptionId $SubscriptionId

    $alreadyExists = $true;
    try {
        Get-AzureRmResourceGroup -Name $ResourceGroupName
        Write-Verbose "Resource group was found, will delete and recreate it."
    }
    catch {
        Write-Verbose "Resource group was not found, will create it."
        $alreadyExists = $false;
    }

    if ($alreadyExists) {
        if($Force -eq $true) {
            # Cleanup the resource group if it already exitsted before
            Remove-AzureRmResourceGroup -Name $ResourceGroupName -Force
            New-AzureRmResourceGroup -Name $ResourceGroupName -Location $AzureLocation
        } else {
            $title = "Delete Resource Group"
            $message = "The resource group you specified already exists. Do you want to clean it up?"

            $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
                "Delete the resource group including all resources."

            $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
                "Keep the resource group and continue."

            $stop = New-Object System.Management.Automation.Host.ChoiceDescription "&Stop", `
                "Stop the current action."

            $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $stop)
            $result = $host.ui.PromptForChoice($title, $message, $options, 0)

            switch ($result)
            {
                0 { Remove-AzureRmResourceGroup -Name $ResourceGroupName -Force; New-AzureRmResourceGroup -Name $ResourceGroupName -Location $AzureLocation }
                1 { <# Do nothing #> }
                2 { exit }
            }
        }
    } else {
        New-AzureRmResourceGroup -Name $ResourceGroupName -Location $AzureLocation
    }

    # This script should follow the recommended naming conventions for azure resources
    $storageAccountName = if($ResourceGroupName.EndsWith("-rg")) {
        $ResourceGroupName.Substring(0, $ResourceGroupName.Length -3)
    } else { $ResourceGroupName }

    # Resource group names may contain special characters, that are not allowed in the storage account name
    $storageAccountName = $storageAccountName.Replace("-", "").Replace("_", "").Replace("(", "").Replace(")", "").ToLower()
    $storageAccountName += "001"

    New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName -Location $AzureLocation -SkuName "Standard_LRS"

    $spDisplayName = [System.GUID]::NewGuid().ToString().ToUpper()
    $sp = New-AzureRmADServicePrincipal -DisplayName $spDisplayName -Password (ConvertTo-SecureString $ServicePrincipalClientSecret -AsPlainText -Force)

    $spAppId = $sp.ApplicationId
    $spClientId = $sp.ApplicationId
    $spObjectId = $sp.Id
    Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup

    New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $spAppId
    Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup
    $sub = Get-AzureRmSubscription -SubscriptionId $SubscriptionId
    $tenantId = $sub.TenantId
    # "", "Note this variable-setting script for running Packer with these Azure resources in the future:", "==============================================================================================", "`$spClientId = `"$spClientId`"", "`$ServicePrincipalClientSecret = `"$ServicePrincipalClientSecret`"", "`$SubscriptionId = `"$SubscriptionId`"", "`$tenantId = `"$tenantId`"", "`$spObjectId = `"$spObjectId`"", "`$AzureLocation = `"$AzureLocation`"", "`$ResourceGroupName = `"$ResourceGroupName`"", "`$storageAccountName = `"$storageAccountName`"", "`$install_password = `"$install_password`"", ""

    Get-LatestCommit -ErrorAction SilentlyContinue

    packer.exe build -on-error=ask `
        -var "client_id=$($spClientId)" `
        -var "client_secret=$($ServicePrincipalClientSecret)" `
        -var "subscription_id=$($SubscriptionId)" `
        -var "tenant_id=$($tenantId)" `
        -var "object_id=$($spObjectId)" `
        -var "location=$($AzureLocation)" `
        -var "resource_group=$($ResourceGroupName)" `
        -var "storage_account=$($storageAccountName)" `
        -var "install_password=$($InstallPassword)" `
        -var "github_feed_token=$($GithubFeedToken)" `
        $builderScriptPath
}
