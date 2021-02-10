Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Get-XcodePaths {
    $xcodePaths = Get-ChildItemWithoutSymlinks "/Applications" -Filter "Xcode_*.app"
    return $xcodePaths | Select-Object -ExpandProperty Fullname
}

function Get-XcodeVersionInfo {
    [string]$output = Invoke-Expression "xcodebuild -version"
    $versionOutputParts = $output.Split(" ")
    return @{
        Version = [System.Version]::Parse($versionOutputParts[1])
        Build = $versionOutputParts[4]
    }
}

function Get-XcodeSDKList {
    $versionInfo = Get-XcodeVersionInfo
    if ($versionInfo.Version -le [System.Version]::Parse("9.4.1")) {
        $output = Invoke-Expression "xcodebuild -showsdks"
        $sdkList = $output | Where-Object { $_ -Match "-sdk" }

        return $sdkList | ForEach-Object {
            $displayName, $canonicalName = $_.Split("-sdk")
            return @{
                canonicalName = $canonicalName.Trim()
                displayName = $displayName.Trim()
            }
        }
    }

    [string]$output = Invoke-Expression "xcodebuild -showsdks -json"
    return $output | ConvertFrom-Json
}

function Get-XcodeInfoList {
    $defaultXcodeRootPath = Get-DefaultXcodeRootPath

    $xcodeInfo = @{}
    Get-XcodePaths | ForEach-Object {
        $xcodeRootPath = $_
        Switch-Xcode -XcodeRootPath $xcodeRootPath

        $versionInfo = Get-XcodeVersionInfo
        $versionInfo.Path = $xcodeRootPath
        $versionInfo.IsDefault = ($xcodeRootPath -eq $defaultXcodeRootPath)
        $versionInfo.IsStable = Test-XcodeStableRelease -XcodeRootPath $xcodeRootPath

        $xcodeInfo.Add($xcodeRootPath, [PSCustomObject] @{
            VersionInfo = $versionInfo
            SDKInfo = Get-XcodeSDKList
            SimulatorsInfo = Get-XcodeSimulatorsInfo
        })
    }

    Switch-Xcode -XcodeRootPath $defaultXcodeRootPath

    return $xcodeInfo
}

function Get-XcodePlatformOrder {
    param (
        [Parameter(Mandatory)]
        [string] $PlatformName
    )

    Switch ($PlatformName) {
        "macOS" { 1 }
        "iOS" { 2 }
        "Simulator - iOS" { 3 }
        "tvOS" { 4 }
        "Simulator - tvOS" { 5 }
        "watchOS" { 6 }
        "Simulator - watchOS" { 7 }
        Default { 100 }
    }
}

function Build-XcodeTable {
    param (
        [Parameter(Mandatory)]
        [hashtable] $xcodeInfo
    )

    $sortRules = @{
        Expression = { $_.Version }
        Descending = $true
    }

    $xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules
    return $xcodeList | ForEach-Object {
        $defaultPostfix = If ($_.IsDefault) { " (default)" } else { "" }
        $betaPostfix = If ($_.IsStable) { "" } else { " (beta)" }
        return [PSCustomObject] @{
            "Version" = $_.Version.ToString() + $betaPostfix + $defaultPostfix
            "Build" = $_.Build
            "Path" = $_.Path
        }
    }
}

function Get-XcodeDevicesList {
    param (
        [Parameter(Mandatory)][object] $XcodeInfo,
        [Parameter(Mandatory)][object] $Runtime
    )

    $runtimeId = $Runtime.identifier
    $runtimeName = $Runtime.name
    $output = $XcodeInfo.SimulatorsInfo.devices.$runtimeId
    if ($null -eq $output) {
        $output = $XcodeInfo.SimulatorsInfo.devices.$runtimeName
    }

    return $output
}

function Build-XcodeSDKTable {
    param (
        [Parameter(Mandatory)]
        [hashtable] $xcodeInfo
    )

    $sdkNames = @()
    $xcodeInfo.Values | ForEach-Object {
        $_.SDKInfo | ForEach-Object {
            $sdkNames += $_.canonicalName
        }
    }

    $sdkNames = $sdkNames | Select-Object -Unique
    return $sdkNames | ForEach-Object {
        $sdkName = $_
        $sdkDisplayName = ""
        $xcodeList = @()
        $xcodeInfo.Values | ForEach-Object {
            $sdk = $_.SDKInfo | Where-Object { $_.canonicalName -eq $sdkName } | Select-Object -First 1
            if ($sdk) {
                $sdkDisplayName = $sdk.displayName
                $xcodeList += $_.VersionInfo.Version
            }
        }

        $xcodeList = $xcodeList | Sort-Object

        return [PSCustomObject] @{
            "SDK" = $sdkDisplayName
            "SDK Name" = $sdkName
            "Xcode Version" = [String]::Join(", ", $xcodeList)
        }
    } | Sort-Object {
            # Sort rule 1
            $sdkNameParts = $_."SDK".Split(" ")
            $platformName = [String]::Join(" ", $sdkNameParts[0..($sdkNameParts.Length - 2)])
            return Get-XcodePlatformOrder $platformName
        }, {
            # Sort rule 2
            $sdkNameParts = $_."SDK".Split(" ")
            return [System.Version]::Parse($sdkNameParts[-1])
        }
}

function Format-XcodeSimulatorName {
    param([Parameter(Mandatory)][string] $Device)
    return $Device.Replace("ʀ", "R")
}

function Build-XcodeSimulatorsTable {
    param (
        [Parameter(Mandatory)]
        [hashtable] $xcodeInfo
    )

    $runtimes = @()
    $xcodeInfo.Values | ForEach-Object {
        $_.SimulatorsInfo.runtimes | ForEach-Object {
            $runtimes += $_
        }
    }

    $runtimes = $runtimes | Sort-Object @{ Expression = { $_.identifier } } -Unique

    return $runtimes | ForEach-Object {
        $runtime = $_
        $runtimeDevices = @()
        $xcodeList = @()

        $xcodeInfo.Values | ForEach-Object {
            $runtimeFound = $_.SimulatorsInfo.runtimes | Where-Object { $_.identifier -eq $runtime.identifier } | Select-Object -First 1
            if ($runtimeFound) {
                $devicesToAdd = Get-XcodeDevicesList -XcodeInfo $_ -Runtime $runtimeFound
                $runtimeDevices += $devicesToAdd | Select-Object -ExpandProperty name
                $xcodeList += $_.VersionInfo.Version
            }
        }

        $xcodeList = $xcodeList | Sort-Object
        $runtimeDevices = $runtimeDevices | ForEach-Object { Format-XcodeSimulatorName $_ } | Select-Object -Unique
        $sortedRuntimeDevices = $runtimeDevices | Sort-Object @{
            Expression = { $_.Split(" ")[0] };
            Descending = $true;
        }, {
            $_.Split(" ") | Select-Object -Skip 1 | Join-String -Separator " "
        }

        return [PSCustomObject] @{
            "OS" = $runtime.name
            "Xcode Version" = [String]::Join("<br>", $xcodeList)
            "Simulators" = [String]::Join("<br>", $sortedRuntimeDevices)
        }
    } | Sort-Object {
        # Sort rule 1
        $sdkNameParts = $_."OS".Split(" ")
        $platformName = [String]::Join(" ", $sdkNameParts[0..($sdkNameParts.Length - 2)])
        return Get-XcodePlatformOrder $platformName
    }, {
        # Sort rule 2
        $sdkNameParts = $_."OS".Split(" ")
        return [System.Version]::Parse($sdkNameParts[-1])
    }
}

function Build-XcodeSupportToolsSection {
    $xcpretty = Run-Command "xcpretty --version"
    $xcversion = Run-Command "xcversion --version" | Select-String "^[0-9]"

    $toolList = @(
        "xcpretty $xcpretty",
        "xcversion $xcversion"
    )

    if ($os.IsLessThanBigSur) {
        $nomadCLI = Run-Command "gem -v nomad-cli"
        $nomadIPA = Run-Command "ipa -version"
        $xctool = Run-Command "xctool --version"
        $toolList += @(
            "Nomad CLI $nomadCLI",
            "Nomad CLI IPA $nomadIPA",
            "xctool $xctool"
        )
    }

    $output = ""
    $output += New-MDHeader "Xcode Support Tools" -Level 4
    $output += New-MDList -Style Unordered -Lines $toolList
    return $output
}