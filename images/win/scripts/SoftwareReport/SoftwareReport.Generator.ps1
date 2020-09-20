Import-Module MarkdownPS
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.VisualStudio.psm1") -DisableNameChecking

$markdown = ""

if ($env:ANNOUNCEMENTS) {
    $markdown += $env:ANNOUNCEMENTS
    $markdown += New-MDNewLine
    $markdown += "***"
    $markdown += New-MDNewLine
}

$OSName = Get-OSName
$markdown += New-MDHeader "$OSName" -Level 1

$OSVersion = Get-OSVersion
$markdown += New-MDList -Style Unordered -Lines @(
    "$OSVersion"
    "Image Version: $env:ImageVersion"
)

if (Test-IsWin19)
{
    $markdown += New-MDHeader "Enabled windows optional features" -Level 2
    $markdown += New-MDList -Style Unordered -Lines @(
        "Windows Subsystem for Linux"
    )
}

$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3

$markdown += New-MDList -Lines (Get-JavaVersionsList -DefaultVersion "1.8.0") -Style Unordered -NoNewLine
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-PythonVersion),
    (Get-RubyVersion),
    (Get-GoVersion),
    (Get-PHPVersion),
    (Get-JuliaVersion),
    (Get-PerlVersion),
    (Get-NodeVersion)
)

$markdown += New-MDHeader "Package Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-ChocoVersion),
    (Get-VcpkgVersion),
    (Get-NPMVersion),
    (Get-YarnVersion),
    (Get-PipVersion),
    (Get-CondaVersion),
    (Get-RubyGemsVersion),
    (Get-HelmVersion),
    (Get-ComposerVersion),
    (Get-NugetVersion)
)

$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-AntVersion),
    (Get-MavenVersion),
    (Get-GradleVersion),
    (Get-SbtVersion)
)

$markdown += New-MDHeader "Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-AzCosmosDBEmulatorVersion),
    (Get-AzCopyVersion),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-CMakeVersion),
    (Get-RVersion),
    (Get-DockerVersion),
    (Get-DockerComposeVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-GoogleCloudSDKVersion),
    (Get-InnoSetupVersion),
    (Get-JQVersion),
    (Get-KubectlVersion),
    (Get-KindVersion),
    (Get-MinGWVersion),
    (Get-MySQLVersion),
    (Get-MercurialVersion),
    (Get-NSISVersion),
    (Get-NewmanVersion),
    (Get-OpenSSLVersion),
    (Get-PackerVersion),
    (Get-PulumiVersion),
    (Get-SQLPSVersion),
    (Get-SQLServerPSVersion),
    (Get-SVNVersion),
    (Get-GHCVersion),
    (Get-CabalVersion),
    (Get-StackVersion),
    (Get-WinAppDriver),
    (Get-ZstdVersion),
    (Get-VSWhereVersion),
    (Get-7zipVersion),
    (Get-YAMLLintVersion)
)

$markdown += New-MDHeader "CLI Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-AzureCLIVersion),
    (Get-AzureDevopsExtVersion),
    (Get-AWSCLIVersion),
    (Get-AWSSAMVersion),
    (Get-AWSSessionManagerVersion),
    (Get-AlibabaCLIVersion),
    (Get-CloudFoundryVersion),
    (Get-HubVersion),
    (Get-GHVersion)
)

$markdown += New-MDHeader "Rust Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    "Rust $(Get-RustVersion)"
)
$markdown += New-MDHeader "Packages" -Level 4
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-BindgenVersion),
    (Get-CbindgenVersion),
    (Get-CargoAuditVersion),
    (Get-CargoOutdatedVersion)
)

$markdown += New-MDHeader "Browsers and webdrivers" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-BrowserVersion -Browser "chrome"),
    (Get-SeleniumWebDriverVersion -Driver "chrome"),
    (Get-BrowserVersion -Browser "edge"),
    (Get-SeleniumWebDriverVersion -Driver "edge"),
    (Get-BrowserVersion -Browser "firefox"),
    (Get-SeleniumWebDriverVersion -Driver "firefox"),
    (Get-SeleniumWebDriverVersion -Driver "iexplorer")
)

$markdown += New-MDHeader "MSYS2" -Level 3
$markdown += Get-PacmanVersion
$markdown += New-MDNewLine
$markdown += @'
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
'@
$markdown += New-MDNewLine

$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += (Build-CachedToolsMarkdown)
$markdown += New-MDNewLine

$markdown += New-MDHeader "Databases" -Level 3
$markdown += Build-DatabasesMarkdown
$markdown += New-MDNewLine

$vs = Get-VisualStudioVersion
$markdown += New-MDHeader "$($vs.Name)" -Level 3
$markdown += $vs | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Workloads, components and extensions:" -Level 4
$markdown += New-MDNewLine
$markdown += ((Get-VisualStudioComponents) + (Get-VisualStudioExtensions)) | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Microsoft Visual C++:" -Level 4
$markdown += New-MDNewLine
$markdown += Get-VisualCPPComponents | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader ".NET Core SDK" -Level 3
$sdk = Get-DotnetSdks
$markdown += "``Location $($sdk.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $sdk.Versions -Style Unordered

$markdown += New-MDHeader ".NET Core Runtime" -Level 3
Get-DotnetRuntimes | Foreach-Object {
    $path = $_.Path
    $versions = $_.Versions
    $markdown += "``Location: $path``"
    $markdown += New-MDNewLine
    $markdown += New-MDList -Lines $versions -Style Unordered
}

$markdown += New-MDHeader ".NET Framework" -Level 3
$frameworks = Get-DotnetFrameworkTools
$markdown += "``Type: Developer Pack``"
$markdown += New-MDNewLine
$markdown += "``Location $($frameworks.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $frameworks.Versions -Style Unordered

# PowerShell Tools
$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellCoreVersion) -Style Unordered

$markdown += New-MDHeader "Azure Powershell Modules" -Level 4
$markdown += Get-PowerShellAzureModules | New-MDTable
$markdown += @'
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
'@
$markdown += New-MDNewLine

$markdown += New-MDHeader "Powershell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Android section
$androidInstalledPackages = Get-AndroidInstalledPackages

$markdown += New-MDHeader "Android SDK Tools" -Level 3
$androidSDKTools = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Tools" -or $_ -Match "Android SDK Platform-Tools" }
$markdown += Build-AndroidSDKToolsTable $androidSDKTools | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android SDK Platforms" -Level 3
$androidSDKPlatforms = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Platform " }
$markdown += New-MDInlineCode -Text (Get-AndroidComponentLocation -ComponentName "platforms")
$markdown += New-MDNewLine
$markdown += Build-AndroidSDKPlatformTable $androidSDKPlatforms | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android SDK Build-Tools" -Level 3
$androidSDKBuildTools = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Build-Tools" }
$markdown += New-MDInlineCode -Text (Get-AndroidComponentLocation -ComponentName "build-tools")
$markdown += New-MDNewLine
$markdown += Build-AndroidSDKBuildtoolsTable $androidSDKBuildTools | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android Extra Packages" -Level 3
$markdown += Build-AndroidExtraPackagesTable $androidInstalledPackages | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Cached Docker images" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(Get-CachedDockerImages)

$markdown | Out-File -FilePath "C:\InstalledSoftware.md"