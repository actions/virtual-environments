param (
    [Parameter(Mandatory)][string]
    $OutputDirectory
)

$ErrorActionPreference = "Stop"

Import-Module MarkdownPS
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Rust.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking

# Restore file owner in user profile
Restore-UserOwner

$markdown = ""

if ($env:ANNOUNCEMENTS) {
    $markdown += $env:ANNOUNCEMENTS
    $markdown += New-MDNewLine
    $markdown += "***"
    $markdown += New-MDNewLine
}

$OSName = Get-OSName
$markdown += New-MDHeader "$OSName" -Level 1

$markdown += New-MDList -Style Unordered -Lines @(
    "Image Version: $env:IMAGE_VERSION"
)

$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3

$markdown += New-MDList -Style Unordered -Lines @(
        (Get-CPPVersions),
        (Get-FortranVersions),
        (Get-ClangVersions),
        (Get-ErlangVersion),
        (Get-MonoVersion),
        (Get-NodeVersion),
        (Get-PythonVersion),
        (Get-Python3Version),
        (Get-PowershellVersion),
        (Get-RubyVersion),
        (Get-SwiftVersion),
        (Get-JuliaVersion)
)

$markdown += New-MDHeader "Package Management" -Level 3

$packageManagementList = @(
        (Get-HomebrewVersion),
        (Get-GemVersion),
        (Get-MinicondaVersion),
        (Get-HelmVersion),
        (Get-NpmVersion),
        (Get-YarnVersion),
        (Get-PipVersion),
        (Get-Pip3Version),
        (Get-VcpkgVersion)
)

if (-not (Test-IsUbuntu16)) {
    $packageManagementList += @(
        (Get-PipxVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($packageManagementList | Sort-Object)

$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
        (Get-AntVersion),
        (Get-GradleVersion),
        (Get-MavenVersion),
        (Get-SbtVersion)
)

$markdown += New-MDHeader "Tools" -Level 3
$toolsList = @(
    (Get-7zipVersion),
    (Get-AnsibleVersion),
    (Get-AzCopy7Version),
    (Get-AzCopy10Version),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-CodeQLBundleVersion),
    (Get-CMakeVersion),
    (Get-CurlVersion),
    (Get-DockerMobyVersion),
    (Get-DockerComposeVersion),
    (Get-DockerBuildxVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-GitFTPVersion),
    (Get-GoogleCloudSDKVersion),
    (Get-HavegedVersion),
    (Get-HerokuVersion),
    (Get-HHVMVersion),
    (Get-SVNVersion),
    (Get-JqVersion),
    (Get-KindVersion),
    (Get-KubectlVersion),
    (Get-KustomizeVersion),
    (Get-LeiningenVersion),
    (Get-M4Version),
    (Get-HGVersion),
    (Get-MinikubeVersion),
    (Get-NewmanVersion),
    (Get-NvmVersion),
    (Get-PackerVersion),
    (Get-PhantomJSVersion),
    (Get-PulumiVersion),
    (Get-RVersion),
    (Get-SphinxVersion),
    (Get-SwigVersion),
    (Get-TerraformVersion),
    (Get-UnZipVersion),
    (Get-WgetVersion),
    (Get-YamllintVersion),
    (Get-ZipVersion),
    (Get-ZstdVersion)
)

if (-not (Test-IsUbuntu16)) {
    $toolsList += @(
        (Get-PodManVersion),
        (Get-BuildahVersion),
        (Get-SkopeoVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($toolsList | Sort-Object)

$markdown += New-MDHeader "CLI Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-AlibabaCloudCliVersion),
    (Get-AWSCliVersion),
    (Get-AWSCliSessionManagerPluginVersion),
    (Get-AWSSAMVersion),
    (Get-AzureCliVersion),
    (Get-AzureDevopsVersion),
    (Get-GitHubCliVersion),
    (Get-HubCliVersion),
    (Get-NetlifyCliVersion),
    (Get-OCCliVersion),
    (Get-ORASCliVersion),
    (Get-VerselCliversion)
)

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "PHP" -Level 3
$markdown += Build-PHPTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Haskell" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-GHCVersion),
    (Get-CabalVersion),
    (Get-StackVersion)
)

$markdown += New-MDHeader "Rust Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-RustVersion),
    (Get-RustupVersion),
    (Get-RustdocVersion),
    (Get-CargoVersion)
)

$markdown += New-MDHeader "Packages" -Level 4
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-BindgenVersion),
    (Get-CargoAuditVersion),
    (Get-CargoOutdatedVersion),
    (Get-CargoClippyVersion),
    (Get-CbindgenVersion),
    (Get-RustfmtVersion)
)

$markdown += New-MDHeader "Browsers and Drivers" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-ChromeVersion),
    (Get-ChromeDriverVersion),
    (Get-FirefoxVersion),
    (Get-GeckodriverVersion)
)

$markdown += New-MDHeader ".NET Core SDK" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-DotNetCoreSdkVersions)
)

$markdown += New-MDHeader "Az Module" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-AzModuleVersions)
)

$markdown += New-MDHeader "Databases" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-PostgreSqlVersion),
    (Get-MongoDbVersion),
    (Get-SqliteVersion)
)

$markdown += Build-MySQLSection

$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += Build-CachedToolsSection

$markdown += New-MDHeader "Android" -Level 3
$markdown += Build-AndroidTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Cached Docker images" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(Get-CachedDockerImages)

$markdown += New-MDHeader "Installed apt packages" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(Get-AptPackages)

$markdown | Out-File -FilePath "${OutputDirectory}/Ubuntu-Readme.md"
