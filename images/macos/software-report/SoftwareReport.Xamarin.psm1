$sortRulesByVersion = @{
    Expression = { [System.Version]::Parse($_) }
    Descending = $true
}

function Get-VSMacVersion {
    $plistPath = "/Applications/Visual Studio.app/Contents/Info.plist"
    return Run-Command "/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' '$plistPath'"
}

function Get-NUnitVersion {
    $version = Run-Command "nunit3-console --version" | Select-Object -First 1 | Take-Part -Part 3
    return "NUnit ${version}"
}

function Build-MonoList {
    $monoVersionsPath = "/Library/Frameworks/Mono.framework/Versions"
    $monoFolders = Get-ChildItemWithoutSymlinks $monoVersionsPath

    $monoVersionList = $monoFolders | ForEach-Object {
        $versionFilePath = Join-Path $_.FullName "Version"
        if (Test-Path $versionFilePath) {
            return Get-Content -Raw $versionFilePath
        }

        return $_.Name
    } | ForEach-Object { $_.Trim() }

    return $monoVersionList | Sort-Object -Property $sortRulesByVersion
}

function Build-XamarinIOSList {
    $sdkVersionsPath = "/Library/Frameworks/Xamarin.iOS.framework/Versions"
    $sdkFolders = Get-ChildItemWithoutSymlinks $sdkVersionsPath

    $sdkVersionList = $sdkFolders | ForEach-Object {
        $versionFilePath = Join-Path $_.FullName "Version"
        if (Test-Path $versionFilePath) {
            return Get-Content -Raw $versionFilePath
        }

        return $_.Name
    } | ForEach-Object { $_.Trim() }

    return $sdkVersionList | Sort-Object -Property $sortRulesByVersion
}

function Build-XamarinMacList {
    $sdkVersionsPath = "/Library/Frameworks/Xamarin.Mac.framework/Versions"
    $sdkFolders = Get-ChildItemWithoutSymlinks $sdkVersionsPath

    $sdkVersionList = $sdkFolders | ForEach-Object {
        $versionFilePath = Join-Path $_.FullName "Version"
        if (Test-Path $versionFilePath) {
            return Get-Content -Raw $versionFilePath
        }

        return $_.Name
    } | ForEach-Object { $_.Trim() }

    return $sdkVersionList | Sort-Object -Property $sortRulesByVersion
}

function Build-XamarinAndroidList {
    $sdkVersionsPath = "/Library/Frameworks/Xamarin.Android.framework/Versions"
    $sdkFolders = Get-ChildItemWithoutSymlinks $sdkVersionsPath

    $sdkVersionList = $sdkFolders | ForEach-Object {
        $versionFilePath = Join-Path $_.FullName "Version"
        if (Test-Path $versionFilePath) {
            return Get-Content -Raw $versionFilePath
        }

        return $_.Name
    } | ForEach-Object { $_.Trim() }

    return $sdkVersionList | Sort-Object -Property $sortRulesByVersion
}