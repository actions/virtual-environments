[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VMName,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIPassword
)

$ProgressPreference = "SilentlyContinue"
$WarningPreference = "SilentlyContinue"

# connection to a vCenter Server system
try
{
    $null = Set-PowerCLIConfiguration -Scope Session -InvalidCertificateAction Ignore -ParticipateInCEIP $false -Confirm:$false -WebOperationTimeoutSeconds 600
    $securePassword = ConvertTo-SecureString -String $VIPassword -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($VIUserName, $securePassword)
    $null = Connect-VIServer -Server $VIServer -Credential $cred -ErrorAction Stop
    Write-Host "Connection to the VIServer has been established"
}
catch
{
    Write-Host "##vso[task.LogIssue type=error;]VISphere connection error"
    exit 1
}

# check vm clone status
$chainId = Get-VIEvent -Entity $VMName | Select-Object -ExpandProperty ChainId -Unique
if ($chainId)
{
    $task = Get-Task -Status Running | Where-Object {$_.Name -eq 'CloneVM_Task' -and $_.ExtensionData.Info.EventChainId -eq $chainId}
    if ($task)
    {
        try
        {
            Stop-Task -Task $task -Confirm:$false -ErrorAction Stop
            Write-Host "The vm '$VMName' clone task has been cancelled"
        }
        catch
        {
            Write-Host "##vso[task.LogIssue type=error;]ERROR: unable to cancel the task"
        }
    }
}

# remove a vm
$vm = Get-VM -Name $VMName -ErrorAction SilentlyContinue

if ($vm)
{
    $vmState = $vm.PowerState
    if ($vmState -ne "PoweredOff")
    {
        try
        {
            Stop-VM -VM $vm -Confirm:$false -ErrorAction Stop
            Write-Host "VM '$VMName' has been powered off"
        }
        catch
        {
            Write-Host "##vso[task.LogIssue type=error;]ERROR: unable to shutdown '$VMName'"
        }
    }

    try
    {
        Remove-VM -VM $vm -DeletePermanently -Confirm:$false -ErrorAction Stop
        Write-Host "VM '$VMName' has been removed"
    }
    catch
    {
        Write-Host "##vso[task.LogIssue type=error;]ERROR: unable to remove '$VMName'"
    }
}
else
{
    Write-Host "VM '$VMName' not found"
}