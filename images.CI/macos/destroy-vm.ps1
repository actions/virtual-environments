<#
.SYNOPSIS

This script deletes vm from vCenter

.PARAMETER VMName
VM name to delete (Example "macOS-10.15_20201012.4")

.PARAMETER VIServer
vCenter address (Example "10.0.1.16")

.PARAMETER VIUserName
vCenter username (Example "Administrator")

.PARAMETER VIPassword
vCenter password (Example "12345678")
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VMName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIPassword
)

# Import helpers module
Import-Module $PSScriptRoot\helpers.psm1 -DisableNameChecking

# Connection to a vCenter Server system
Connect-VCServer

# Check vm clone status
$chainId = (Get-VIEvent -Entity $VMName).ChainId
if ($chainId)
{
    $task = Get-Task -Status Running | Where-Object { ($_.Name -eq 'CloneVM_Task') -and ($_.ExtensionData.Info.EventChainId -in $chainId) }
    if ($task)
    {
        try
        {
            Stop-Task -Task $task -Confirm:$false -ErrorAction Stop
            Write-Host "The vm '$VMName' clone task has been canceled"
        }
        catch
        {
            Write-Host "##vso[task.LogIssue type=error;]Failed to cancel the task"
        }
    }
}

# Remove a vm
$vm = Get-VM -Name $VMName -ErrorAction SilentlyContinue

if ($vm)
{
    $vmState = $vm.PowerState
    if ($vmState -ne "PoweredOff")
    {
        try
        {
            $null = Stop-VM -VM $vm -Confirm:$false -ErrorAction Stop
            Write-Host "The vm '$VMName' has been powered off"
        }
        catch
        {
            Write-Host "##vso[task.LogIssue type=error;]Failed to shutdown '$VMName'"
        }
    }

    try
    {
        Remove-VM -VM $vm -DeletePermanently -Confirm:$false -ErrorAction Stop
        Write-Host "The vm '$VMName' has been removed"
    }
    catch
    {
        Write-Host "##vso[task.LogIssue type=error;]Failed to remove '$VMName'"
    }
}
else
{
    Write-Host "VM '$VMName' not found"
}