Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Split-TableRowByColumns {
    param(
        [string] $Row
    )
    return $Row.Split("|") | ForEach-Object { $_.trim() }
}

function Build-AndroidTableObject {
    param(
        [string] $PackageName,
        [string] $Description
    )
    return [PSCustomObject] @{
        "Package Name" = $PackageName
        "Description" = $Description
    }
}

function Get-AndroidSDKRoot {
    return Join-Path $env:HOME "Library" "Android" "sdk"
}

function Get-AndroidSDKManagerPath {
    $androidSDKDir = Get-AndroidSDKRoot
    return Join-Path $androidSDKDir "tools" "bin" "sdkmanager"
}

function Get-AndroidInstalledPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = Invoke-Expression "$androidSDKManagerPath --list --include_obsolete"
    $androidInstalledPackages = @()
    foreach($packageInfo in $androidSDKManagerList) {
        if($packageInfo -Match "Available Packages:") {
            break
        }

        $androidInstalledPackages += $packageInfo
    }
    return $androidInstalledPackages
}

function Build-AndroidSDKToolsTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )
    
    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0]
        $packageDescription = $packageInfoParts[2] + ", Revision " + $packageInfoParts[1]
        return Build-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidSDKPlatformTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )

    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0].split(";")[1]
        $packageDescription = $packageInfoParts[2] + ", Revision " + $packageInfoParts[1]
        return Build-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidSDKBuildToolsTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )

    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0].replace(";", "-")
        $packageDescription = "Android SDK Build-Tools, Revision " + $packageInfoParts[1]
        return Build-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidNDKTable {
    param (
        [Parameter(Mandatory)][AllowEmptyString()]
        [string[]] $installedPackages
    )

    $ndkInfo = @()

    if ($os.IsLessThanBigSur) {
        $ndkInfo += [PSCustomObject] @{
            # Hardcode NDK 15 as a separate case since it is installed manually without sdk-manager (to none default location)
            "Version" = "15.2.4203891"
            "Path" = Join-Path (Get-AndroidSDKRoot) "android-ndk-r15c"
        }
        
        $ndkFolderPath = Join-Path (Get-AndroidSDKRoot) "ndk"
        $ndkInfo += Get-ChildItem -Path $ndkFolderPath | ForEach-Object {
            return [PSCustomObject] @{
                "Version" = $_.Name
                "Path" = $_.FullName
            }
        }
    }
    
    $ndkBundleInfo = $installedPackages | Where-Object { $_ -Match "ndk-bundle" } | Select-Object -First 1
    $ndkBundleVersion = (Split-TableRowByColumns $ndkBundleInfo)[1]
    $ndkInfo += [PSCustomObject] @{
        "Version" = $ndkBundleVersion
        "Path" = Join-Path (Get-AndroidSDKRoot) "ndk-bundle"
    }

    $ndkInfo | ForEach-Object {
        $_.Path = $_.Path.Replace($env:HOME, '$HOME')
    }
    
    return $ndkInfo
}

function Build-AndroidUtilsTable {
    param (
        [Parameter(Mandatory)][AllowEmptyString()]
        [string[]] $installedPackages
    )

    $utilsList = @("cmake", "Android Emulator")
    return $utilsList | ForEach-Object {
        $packageName = $_
        $packageInfo = $installedPackages | Where-Object { $_ -Match $packageName } | Select-Object -First 1
        $packageInfoParts = Split-TableRowByColumns $packageInfo
        return [PSCustomObject] @{
            "Package Name" = $packageName
            "Version" = $packageInfoParts[1]
        }
    }
}

function Build-AndroidExtraPackagesTable {
    param (
        [Parameter(Mandatory)][AllowEmptyString()]
        [string[]] $installedPackages
    )

    $extraPackages = @(
        "Android Support Repository",
        "Google Play services",
        "Google Repository",
        "Hardware_Accelerated_Execution_Manager"
    )

    return $extraPackages | ForEach-Object {
        $packageId = $_
        $packageInfo = $installedPackages | Where-Object { $_ -Like "*${packageId}*" } | Select-Object -First 1
        $packageInfoParts = Split-TableRowByColumns $packageInfo
        return [PSCustomObject] @{
            "Package Name" = $packageInfoParts[2]
            "Version" = $packageInfoParts[1]
        }
    }
}