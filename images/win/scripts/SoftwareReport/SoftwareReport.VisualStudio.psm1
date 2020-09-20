function Get-VisualStudioVersion {
    $vsVersion = vswhere -format json | ConvertFrom-Json
    [PSCustomObject]@{
        Name = $vsVersion.displayName
        Version = $vsVersion.installationVersion
        Path = $vsVersion.installationPath
    }
}

function Get-WixVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -match "wix" } | Select-Object -First 1).DisplayVersion
}

function Get-WDKVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -eq 'Windows Driver Kit' } | Select-Object -First 1).DisplayVersion
}

function Get-VisualStudioExtensions {
    # Wix
    $vs = (Get-VisualStudioVersion).Name.Split()[-1]
    $wixPackageVersion = Get-WixVersion
    $wixExtensionVersion = (Get-VisualStudioPackages | Where-Object {$_.Id -match 'WixToolset.VisualStudioExtension.Dev' -and $_.type -eq 'vsix'}).Version

    # WDK
    $wdkPackageVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
    $wdkExtensionVersion = Get-WDKVersion

    # SSDT
    $analysisPackageVersion = Get-VSExtensionVersion -packageName '04a86fc2-dbd5-4222-848e-911638e487fe'
    $reportingPackageVersion = Get-VSExtensionVersion -packageName '717ad572-c4b7-435c-c166-c2969777f718'

    $integrationPackageName = ($vs -match "2019") ? '851E7A09-7B2B-4F06-A15D-BABFCB26B970' : 'D1B09713-C12E-43CC-9EF4-6562298285AB'
    $integrationPackageVersion = Get-VSExtensionVersion -packageName $integrationPackageName

    $extensions = @(
        @{Package = 'SSDT Microsoft Analysis Services Projects'; Version = $analysisPackageVersion}
        @{Package = 'SSDT SQL Server Integration Services Projects'; Version = $integrationPackageVersion}
        @{Package = 'SSDT Microsoft Reporting Services Projects'; Version = $reportingPackageVersion}
        @{Package = 'Windows Driver Kit'; Version = $wixPackageVersion}
        @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion}
        @{Package = 'WIX Toolset'; Version = $wixPackageVersion}
        @{Package = "WIX Toolset Studio $vs Extension"; Version = $wixExtensionVersion}
    )

    $extensions | Foreach-Object {
        [PSCustomObject]$_
    } | Select-Object Package, Version
}