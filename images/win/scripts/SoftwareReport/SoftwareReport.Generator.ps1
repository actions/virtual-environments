Import-Module MarkdownPS
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.VisualStudio.psm1") -DisableNameChecking

$markdown = ""

$OSName = Get-OSName
$markdown += New-MDHeader "$OSName" -Level 1

$OSVersion = Get-OSVersion
$markdown += New-MDList -Style Unordered -Lines @(
    "$OSVersion"
    "Image Version: $env:IMAGE_VERSION"
)

if (Test-IsWin19)
{
    $markdown += New-MDHeader "Enabled windows optional features" -Level 2
    $markdown += New-MDList -Style Unordered -Lines @(
        "Windows Subsystem for Linux [WSLv1]"
    )
}

$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-BashVersion),
    (Get-GoVersion),
    (Get-JuliaVersion),
    (Get-NodeVersion),
    (Get-PerlVersion),
    (Get-PHPVersion),
    (Get-PythonVersion),
    (Get-RubyVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Package Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-ChocoVersion),
    (Get-ComposerVersion),
    (Get-HelmVersion),
    (Get-CondaVersion),
    (Get-NPMVersion),
    (Get-NugetVersion),
    (Get-PipxVersion),
    (Get-PipVersion),
    (Get-RubyGemsVersion),
    (Get-VcpkgVersion),
    (Get-YarnVersion)
    ) | Sort-Object
)
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-PackageManagementEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-AntVersion),
    (Get-GradleVersion),
    (Get-MavenVersion),
    (Get-SbtVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-7zipVersion),
    (Get-Aria2Version),
    (Get-AzCopyVersion),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-BicepVersion),
    (Get-CabalVersion),
    (Get-CMakeVersion),
    (Get-CodeQLBundleVersion),
    (Get-DockerVersion),
    (Get-DockerComposeVersion),
    (Get-GHCVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-GoogleCloudSDKVersion),
    (Get-InnoSetupVersion),
    (Get-JQVersion),
    (Get-KindVersion),
    (Get-KubectlVersion),
    (Get-MercurialVersion),
    (Get-MinGWVersion),
    (Get-NewmanVersion),
    (Get-NSISVersion),
    (Get-OpenSSLVersion),
    (Get-PackerVersion),
    (Get-PulumiVersion),
    (Get-RVersion),
    (Get-StackVersion),
    (Get-SVNVersion),
    (Get-VSWhereVersion),
    (Get-SwigVersion),
    (Get-WinAppDriver),
    (Get-ZstdVersion),
    (Get-YAMLLintVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "CLI Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-AlibabaCLIVersion),
    (Get-AWSCLIVersion),
    (Get-AWSSAMVersion),
    (Get-AWSSessionManagerVersion),
    (Get-AzureCLIVersion),
    (Get-AzureDevopsExtVersion),
    (Get-CloudFoundryVersion),
    (Get-GHVersion),
    (Get-HubVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Rust Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    "Rust $(Get-RustVersion)",
    "Rustup $(Get-RustupVersion)",
    "Cargo $(Get-RustCargoVersion)",
    "Rustdoc $(Get-RustdocVersion)"
    ) | Sort-Object
)

$markdown += New-MDHeader "Packages" -Level 4
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-BindgenVersion),
    (Get-CargoAuditVersion),
    (Get-CargoOutdatedVersion),
    (Get-CbindgenVersion),
    "Rustfmt $(Get-RustfmtVersion)",
    "Clippy $(Get-RustClippyVersion)"
    ) | Sort-Object
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

$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Shells" -Level 3
$markdown += Get-ShellTarget
$markdown += New-MDNewLine

$markdown += New-MDHeader "MSYS2" -Level 3
$markdown += Get-PacmanVersion
$markdown += New-MDNewLine
$markdown += New-MDHeader "Notes:" -Level 5
$markdown += @'
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
'@
$markdown += New-MDNewLine

if (Test-IsWin19)
{
    $markdown += New-MDHeader "BizTalk Server" -Level 3
    $markdown += Get-BizTalkVersion
    $markdown += New-MDNewLine
}

$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += (Build-CachedToolsMarkdown)
$markdown += New-MDNewLine

$markdown += New-MDHeader "Databases" -Level 3
$markdown += Build-DatabasesMarkdown
$markdown += New-MDNewLine

$markdown += New-MDHeader "Database tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-AzCosmosDBEmulatorVersion),
    (Get-DacFxVersion),
    (Get-MySQLVersion),
    (Get-SQLPSVersion)
    ) | Sort-Object
)
$markdown += New-MDNewLine

$markdown += Build-WebServersSection

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
$markdown += New-MDHeader "Android" -Level 3
$markdown += Build-AndroidTable | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-AndroidEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

# Docker images section
$markdown += New-MDHeader "Cached Docker images" -Level 3
$markdown += Get-CachedDockerImagesTableData | New-MDTable
$markdown += New-MDNewLine

$markdown | Out-File -FilePath "C:\InstalledSoftware.md"
