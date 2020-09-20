Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Android.psm1") -DisableNameChecking

Describe "Android SDK" {
    $androidToolset = (Get-ToolsetContent).android
    $androidInstalledPackages = Get-AndroidInstalledPackages

    $platformTestCases = @()
    $platformList = $androidToolset.platform_list
    $platformList | ForEach-Object {
        $platformTestCases += @{ platformVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $buildToolsTestCases = @()
    $buildToolsList = $androidToolset.build_tools
    $buildToolsList | ForEach-Object {
        $buildToolsTestCases += @{ buildToolsVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $extraPackagesTestCases = @()
    $extraPackageList = $androidToolset.extra_list
    $extraPackageList | ForEach-Object {
        $extraPackagesTestCases += @{ extraPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $addonsTestCases = @()
    $addonsPackageList = $androidToolset.addon_list
    $addonsPackageList | ForEach-Object {
        $addonsTestCases += @{ addonPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $additionalToolsTestCases = @()
    $additionalToolsList = $androidToolset.additional_tools
    $additionalToolsList | ForEach-Object {
        $additionalToolsTestCases += @{ additionalToolVersion = $_; installedPackages = $androidInstalledPackages }
    }

    It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
        "$installedPackages" | Should -Match "platforms;$platformVersion"
    }

    It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
        "$installedPackages" | Should -Match "build-tools;$buildToolsVersion"
    }

    if (Test-isWin19) {
        It "Extra package <extraPackage> is installed" -TestCases $extraPackagesTestCases {
            "$installedPackages" | Should -Match "extras;$extraPackage"
        }

        It "Addon package <addonPackage> is installed" -TestCases $addonsTestCases {
            "$installedPackages" | Should -Match "add-ons;$addonPackage"
        }
    }

    It "Additional tool <additionalToolVersion> is installed" -TestCases $additionalToolsTestCases {
        "$installedPackages" | Should -Match $additionalToolVersion
    }
}