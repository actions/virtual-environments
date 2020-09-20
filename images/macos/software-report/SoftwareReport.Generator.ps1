param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

Import-Module MarkdownPS
Import-Module "$PSScriptRoot/SoftwareReport.Common.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xcode.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Android.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Java.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xamarin.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

# Language and Runtime
$nodejsVersion = Run-Command "node --version"
$nvmVersion = Get-NVMVersion
$nvmCachedVersions = Get-NVMNodeVersionList
$pythonVersion = Run-Command "python --version"
$python3Version = Run-Command "python3 --version"
$rubyVersion = Run-Command "ruby --version" | Take-Part -Part 1
$goVersion = Get-GoVersion
$phpVersion = Run-Command "php --version" | Select-Object -First 1 | Take-Part -Part 0,1
$juliaVersion = Run-Command "julia --version" | Take-Part -Part 0,2

$markdown = ""

# Get announcements
if ($env:ANNOUNCEMENTS) {
    $markdown += $env:ANNOUNCEMENTS
    $markdown += New-MDNewLine
    $markdown += "***"
    $markdown += New-MDNewLine
}

# OS info
$markdown += Build-OSInfoSection
$markdown += New-MDList -Style Unordered -Lines ("Image Version: {0}" -f $ImageName.Split('_')[1])
# Software report
$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3

if ( -not $os.IsHighSierra) {
    $clangLLVMVersion = Get-ClangLLVMVersion
    $gccVersion = Get-GccVersion
    $gfortranVersion = Get-FortranVersion
    $lines = @($clangLLVMVersion, $gccVersion, $gfortranVersion) | ForEach-Object {$_}
    $markdown += New-MDList -Style Unordered -NoNewLine -Lines $lines
}

$markdown += New-MDList -Style Unordered -Lines @(
    "Node.js ${nodejsVersion}"
    "NVM ${nvmVersion}"
    "NVM - Cached node versions: ${nvmCachedVersions}"
    $pythonVersion,
    $python3Version,
    "Ruby ${rubyVersion}",
    (Get-DotnetVersionList),
    (Get-RVersion),
    "Go ${goVersion}",
    "$phpVersion",
    "$juliaVersion"
)

# Package Management
$bundlerVersion = Run-Command "bundle --version"
$carthageVersion = Run-Command "carthage version" -SuppressStderr
$cocoaPodsVersion = Run-Command "pod --version"
$homebrewVersion = Run-Command "brew --version" | Select-Object -First 1
$npmVersion = Run-Command "npm --version"
$yarnVersion = Run-Command "yarn --version"
$nugetVersion = Run-Command "nuget help" | Select-Object -First 1 | Take-Part -Part 2
$pipVersion = Get-PipVersion -Version 2
$pip3Version = Get-PipVersion -Version 3
$condaVersion = Invoke-Expression "conda --version"
$rubyGemsVersion = Run-Command "gem --version"
$composerVersion = Run-Command "composer --version" | Take-Part -Part 2

$markdown += New-MDHeader "Package Management" -Level 3
if ($os.IsHigherThanMojave) {
    $vcpkgVersion = Get-VcpkgVersion
    $markdown += New-MDList -Lines $vcpkgVersion -Style Unordered -NoNewLine
}
$markdown += New-MDList -Style Unordered -Lines @(
    $bundlerVersion,
    "Carthage ${carthageVersion}",
    "CocoaPods ${cocoaPodsVersion}",
    $homebrewVersion,
    "NPM ${npmVersion}",
    "Yarn ${yarnVersion}",
    "NuGet ${nugetVersion}",
    "Pip ${pipVersion}",
    "Pip ${pip3Version}",
    "Mini${condaVersion}",
    "RubyGems ${rubyGemsVersion}",
    "Composer ${composerVersion}"
)

# Project Management
$mavenVersion = Run-Command "mvn -version" | Select-Object -First 1 | Take-Part -Part 2
#gradle output differs on the first launch – a welcome message, that we don't need is rendered. The solution is to take the last "Gradle" occurrence from the output
$gradleVersion = (Run-Command "gradle --version" | Select-String "Gradle")[-1]
$apacheAnt = Run-Command "ant -version"  | Take-Part -Part 0,1,3

$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    "Apache Maven ${mavenVersion}",
    $gradleVersion,
    $apacheAnt
)

# Utilities
$curlVersion = Run-Command "curl --version" | Select-Object -First 1 | Take-Part -Part 1
$gitVersion = Run-Command "git --version" | Take-Part -Part 2
$ghVersion = Run-Command "gh --version" | Select-String "gh version" | Select-Object -First 1 | Take-Part -Part 2
$gitLFSVersion = Run-Command "git-lfs version" | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
$hubVersion = Run-Command "hub version | grep 'hub version'" | Take-Part -Part 2
$wgetVersion = Run-Command "wget --version" | Select-String "GNU Wget" | Take-Part -Part 2
$svnVersion = Run-Command "svn --version --quiet"
$parallelVersion = Run-Command "parallel --version" | Select-String "GNU parallel" | Select-Object -First 1
$jqVersion = Run-Command "jq --version" | Take-Part -Part 1 -Delimiter "-"
$opensslVersion = Get-Item /usr/local/opt/openssl | ForEach-Object {"{0} ``({1} -> {2})``" -f (Run-Command "openssl version"), $_.FullName, $_.Target}
$gpgVersion = Run-Command "gpg --version" | Select-String 'gpg (GnuPG)' -SimpleMatch
$postgresClientVersion = Run-Command "psql --version"
$postgresServerVersion = Run-Command "pg_config --version"
$aria2Version = Run-Command "aria2c --version" | Select-Object -First 1 | Take-Part -Part 2
$azcopyVersion = Run-Command "azcopy --version" | Take-Part -Part 2
$zstdVersion = Run-Command "zstd --version" | Take-Part -Part 1 -Delimiter "v" | Take-Part -Part 0 -Delimiter ","
$bazelVersion = Run-Command "bazel --version" | Take-Part -Part 0 -Delimiter "-"
$bazeliskVersion = Run-Command "bazelisk version" | Select-String "Bazelisk version:" | Take-Part -Part 1 -Delimiter ":"
$packerVersion = Run-Command "packer --version"
$helmVersion = Run-Command "helm version --short"
$vbox = Run-Command "vboxmanage -v"
$vagrant = Run-Command "vagrant -v"
$mongo = Run-Command "mongo --version" | Select-String "MongoDB shell version" | Take-Part -Part 3
$mongod = Run-Command "mongod --version" | Select-String "db version " | Take-Part -Part 2
$p7zip = Run-Command "7z i" | Select-String "7-Zip" | Take-Part -Part 0,2

$markdown += New-MDHeader "Utilities" -Level 3
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    "Curl ${curlVersion}",
    "Git: ${gitVersion}",
    "Git LFS: ${gitLFSVersion}",
    "GitHub CLI: ${ghVersion}",
    "Hub CLI: ${hubVersion}",
    "GNU Wget ${wgetVersion}",
    "Subversion (SVN) ${svnVersion}",
    "Packer $packerVersion",
    $parallelVersion,
    $opensslVersion,
    "jq ${jqVersion}",
    $gpgVersion,
    $postgresClientVersion,
    $postgresServerVersion,
    "aria2 $aria2Version",
    "azcopy $azcopyVersion",
    "zstd $zstdVersion",
    $bazelVersion,
    "bazelisk $($bazeliskVersion.Trim())",
    "helm $helmVersion",
    "virtualbox $vbox",
    "mongo $mongo",
    "mongod $mongod",
    "$vagrant",
    $p7zip
)
if ($os.IsHigherThanMojave) {
    $newmanVersion = Run-Command "newman --version"
    $markdown += New-MDList -Lines "Newman $newmanVersion" -Style Unordered
}
$markdown += New-MDNewLine

# Tools
$fastlaneVersion = Run-Command "fastlane --version" | Select-String "^fastlane [0-9]" | Take-Part -Part 1
$cmakeVersion = Run-Command "cmake --version" | Select-Object -First 1 | Take-Part -Part 2
$appcenterCLIVersion = Run-Command "appcenter --version" | Take-Part -Part 2
$azureCLIVersion = Run-Command "az -v" | Select-String "^azure-cli" | Take-Part -Part 1
$awsVersion = Run-Command "aws --version" | Take-Part -Part 0 | Take-Part -Delimiter "/" -Part 1
$aliyunVersion = Run-Command "aliyun --version" | Select-String "Alibaba Cloud Command Line Interface Version " | Take-Part -Part 6
$awsSamVersion = Run-Command "sam --version" | Take-Part -Part 3
$awsSessionManagerVersion = Run-Command "session-manager-plugin --version" 
$ghcUpVersion = Run-Command "ghcup --version" | Take-Part -Part 5
$ghcVersion = Run-Command "ghc --version" | Take-Part -Part 7 
$cabalVersion = Run-Command "cabal --version" | Take-Part -Part 3
$stackVersion = Run-Command "stack --version" | Take-Part -Part 1 | ForEach-Object {$_.replace(",","")}

$markdown += New-MDHeader "Tools" -Level 3
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    "Fastlane ${fastlaneVersion}",
    "Cmake ${cmakeVersion}",
    "App Center CLI ${appcenterCLIVersion}",
    "Azure CLI ${azureCLIVersion}",
    "AWS CLI ${awsVersion}",
    "AWS SAM CLI ${awsSamVersion}",
    "AWS Session Manager CLI ${awsSessionManagerVersion}",
    "Aliyun CLI ${aliyunVersion}"
)

if( -not $os.IsHighSierra) {
    $markdown += New-MDList -Style Unordered -Lines @(
        "GHCup ${ghcUpVersion}",
        "GHC ${ghcVersion}",
        "Cabal ${cabalVersion}",
        "Stack ${stackVersion}"
    )
}

# Linters
$markdown += New-MDHeader "Linters" -Level 3
$yamllintVersion = Run-Command "yamllint --version"
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    $yamllintVersion
)

if ( -not $os.IsHighSierra) {
    $swiftlintVersion = Run-Command "swiftlint version"
    $markdown += New-MDList -Style Unordered -Lines @(
        "SwiftLint ${swiftlintVersion}"
    )
}

$markdown += New-MDHeader "Browsers" -Level 3
$markdown += Get-BrowserSection

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable

# Toolcache
$markdown += Build-ToolcacheSection

if ( -not $os.IsHighSierra) {
    $rustVersion = Get-RustVersion
    $markdown += New-MDHeader "Rust Tools" -Level 3
    $markdown += New-MDList -Style Unordered -Lines @(
        "Rust $rustVersion",
        (Get-RustupVersion)
    )
    $markdown += New-MDHeader "Packages" -Level 4
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-Bindgen),
        (Get-Cbindgen),
        (Get-Cargooutdated),
        (Get-Cargoaudit)
    )
}

$markdown += New-MDHeader "PowerShell Tools" -Level 3
$powershellVersion = Run-Command "powershell --version"
$markdown += New-MDList -Lines $powershellVersion -Style Unordered

$markdown += New-MDHeader "PowerShell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Xamarin section
$markdown += New-MDHeader "Xamarin" -Level 3
$markdown += New-MDHeader "Visual Studio for Mac" -Level 4
$markdown += New-MDList -Lines @(Get-VSMacVersion) -Style Unordered

$markdown += New-MDHeader "Mono" -Level 4
$markdown += New-MDList -Lines (Build-MonoList) -Style Unordered

$markdown += New-MDHeader "Xamarin.iOS" -Level 4
$markdown += New-MDList -Lines (Build-XamarinIOSList) -Style Unordered

$markdown += New-MDHeader "Xamarin.Mac" -Level 4
$markdown += New-MDList -Lines (Build-XamarinMacList) -Style Unordered

$markdown += New-MDHeader "Xamarin.Android" -Level 4
$markdown += New-MDList -Lines (Build-XamarinAndroidList) -Style Unordered

$markdown += New-MDHeader "Unit Test Framework" -Level 4
$markdown += New-MDList -Lines @(Get-NUnitVersion) -Style Unordered

# Xcode section
$xcodeInfo = Get-XcodeInfoList
$markdown += New-MDHeader "Xcode" -Level 3
$markdown += Build-XcodeTable $xcodeInfo | New-MDTable
$markdown += New-MDNewLine

$markdown += Build-XcodeSupportToolsSection

$markdown += New-MDHeader "Installed SDKs" -Level 4
$markdown += Build-XcodeSDKTable $xcodeInfo | New-MDTable
$markdown += New-MDNewLine

# Disable simulators table on 11.0 beta for now since "simctl" tool doesn't work properly
if (-not $os.IsBigSur) {
    $markdown += New-MDHeader "Installed Simulators" -Level 4
    $markdown += Build-XcodeSimulatorsTable $xcodeInfo | New-MDTable
    $markdown += New-MDNewLine
}

# Android section
$markdown += New-MDHeader "Android" -Level 3
$androidInstalledPackages = Get-AndroidInstalledPackages

$markdown += New-MDHeader "Android SDK Tools" -Level 4
$androidSDKTools = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Tools" }
$markdown += Build-AndroidSDKToolsTable $androidSDKTools | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android SDK Platform-Tools" -Level 4
$androidSDKPlatformTools = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Platform-Tools" }
$markdown += Build-AndroidSDKToolsTable $androidSDKPlatformTools | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android SDK Platforms" -Level 4
$androidSDKPlatforms = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Platform " }
$markdown += Build-AndroidSDKPlatformTable $androidSDKPlatforms | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android SDK Build-Tools" -Level 4
$androidSDKBuildTools = $androidInstalledPackages | Where-Object { $_ -Match "Android SDK Build-Tools" }
$markdown += Build-AndroidSDKBuildtoolsTable $androidSDKBuildTools | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android NDKs"  -Level 4
$markdown += Build-AndroidNDKTable $androidInstalledPackages | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Android Utils" -Level 4
$markdown += Build-AndroidUtilsTable $androidInstalledPackages | New-MDTable
$markdown += New-MDNewLine

$androidGoogleAPIsTable = $androidInstalledPackages | Where-Object { $_ -Match "Google APIs" }
if ($androidGoogleAPIsTable.Count -gt 0) {
    $markdown += New-MDHeader "Android Google APIs" -Level 4
    $markdown += Build-AndroidSDKPlatformTable $androidGoogleAPIsTable | New-MDTable
    $markdown += New-MDNewLine
}

$markdown += New-MDHeader "Extra Packages" -Level 4
$markdown += Build-AndroidExtraPackagesTable $androidInstalledPackages | New-MDTable
$markdown += New-MDNewLine

#
# Generate systeminfo.txt with information about image (for debug purpose)
#
$dateTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$systemInfo = [string]::Join([System.Environment]::NewLine, @(
    "Date: ${dateTime}",
    "Image name: ${ImageName}"
))


if (-not (Test-Path $OutputDirectory)) { New-Item -Path $OutputDirectory -ItemType Directory | Out-Null }

#
# Write final reports
#
Write-Host $markdownExtended
$systemInfo | Out-File -FilePath "${OutputDirectory}/systeminfo.txt" -Encoding UTF8NoBOM
$markdown | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM