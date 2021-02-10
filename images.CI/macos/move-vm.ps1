<#
.SYNOPSIS

This script migrates given VM to another datastore

.PARAMETER VMName
VM name to migrate (Example "macOS-10.15_20201012.4")

.PARAMETER TargetDataStore
Target datastore (Example "ds-image")

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
    [string]$TargetDataStore,

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

try
{
    Get-VM $VMName | Move-VM -Datastore $TargetDataStore -ErrorAction Stop
    Write-Host "VM has been moved successfully to target datastore '$TargetDataStore'"
}
catch
{
    Write-Host "##vso[task.LogIssue type=error;]Failed to move VM '$VMName' to target datastore '$TargetDataStore'"
}