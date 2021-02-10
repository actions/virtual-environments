<#
.SYNOPSIS

Helper functions to use in images.CI scripts
#>

Function Connect-VCServer
{
    try
    {
        # Preference
        $global:ProgressPreference = 'SilentlyContinue'
        $global:WarningPreference = 'SilentlyContinue'
        # Ignore SSL
        $null = Set-PowerCLIConfiguration -Scope Session -InvalidCertificateAction Ignore -ParticipateInCEIP $false -Confirm:$false -WebOperationTimeoutSeconds 600
        $securePassword = ConvertTo-SecureString -String $VIPassword -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential($VIUserName, $securePassword)
        $null = Connect-VIServer -Server $VIServer -Credential $cred -ErrorAction Stop
        Write-Host "Connection to the vSphere server has been established"
    }
    catch
    {
        Write-Host "##vso[task.LogIssue type=error;]Failed to connect to the vSphere server"
        exit 1
    }
}