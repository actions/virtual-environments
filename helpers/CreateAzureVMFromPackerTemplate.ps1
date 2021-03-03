Function CreateAzureVMFromPackerTemplate {
    <#
        .SYNOPSIS
            A helper function to deploy a VM from a generated image.

        .DESCRIPTION
             Creates an Azure VM from a template. Also generates network resources in Azure to make the VM accessible.

        .PARAMETER SubscriptionId
            The Azure subscription Id where resources will be created.

        .PARAMETER ResourceGroupName
            The Azure resource group name where the Azure virtual machine will be created.

        .PARAMETER TemplatFilePath
            The path for the json template generated by packer during image generation locally.

        .PARAMETER VirtualMachineName
            The name of the virtual machine to be generated.

        .PARAMETER AdminUserName
            The administrator username for the virtual machine to be created.

        .PARAMETER AdminPassword
            The administrator password for the virtual machine to be created.

        .PARAMETER AzureLocation
            The location where the Azure virtual machine will be provisioned. Example: "westeurope"

        .EXAMPLE
            CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId}  -ResourceGroupName {ResourceGroupName} -TemplateFile "C:\BuildVmImages\temporaryTemplate.json" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "westeurope"
    #>
    param (
        [Parameter(Mandatory = $True)]
        [string] $SubscriptionId,
        [Parameter(Mandatory = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True)]
        [string] $TemplateFilePath,
        [Parameter(Mandatory = $True)]
        [string] $VirtualMachineName,
        [Parameter(Mandatory = $True)]
        [string] $AdminUsername,
        [Parameter(Mandatory = $True)]
        [string] $AdminPassword,
        [Parameter(Mandatory = $True)]
        [string] $AzureLocation
    )

    $vmSize = "Standard_DS2_v2"
    $vnetName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $subnetName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $nicName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $publicIpName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()

    Write-Host "Creating a virtual network and subnet"
    ($vnet = az network vnet create -g $ResourceGroupName -l $AzureLocation -n $vnetName --address-prefixes 10.0.0.0/16 --subnet-name $subnetName --subnet-prefixes 10.0.1.0/24 --subscription $subscriptionId)
    $subnetId = ($vnet | ConvertFrom-Json).newVNet.subnets[0].id

    Write-Host "`nCreating a network interface controller (NIC)"
    ($nic = az network nic create -g $ResourceGroupName -l $AzureLocation -n $nicName --subnet $subnetId --subscription $subscriptionId)
    $networkId = ($nic | ConvertFrom-Json).NewNIC.id

    Write-Host "`nCreating a public IP address"
    ($publicIp = az network public-ip create -g $ResourceGroupName -l $AzureLocation -n $publicIpName --allocation-method Static --sku Standard --version IPv4 --subscription $subscriptionId)
    $publicIpId = ($publicIp | ConvertFrom-Json).publicIp.id

    Write-Host "`nAdding the public IP to the NIC"
    az network nic ip-config update -g $ResourceGroupName -n ipconfig1 --nic-name $nicName --public-ip-address $publicIpId --subscription $subscriptionId

    Write-Host "`nCreating the VM"
    az group deployment create -g $ResourceGroupName -n $VirtualMachineName --subscription $subscriptionId --template-file $templateFilePath  vmSize=$vmSize vmName=$VirtualMachineName adminUserName=$AdminUsername adminPassword=$AdminPassword networkInterfaceId=$networkId
}
