Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$toolsets = Get-ChildItem -Path $PSScriptRoot -Filter "toolset-*.json"

function Get-ShortVersion([System.Version] $Version) {
    return [System.Version]::Parse($Version).ToString(2)
}

function Invoke-BashUtilsFunction([string] $FunctionName, [string]$parameter) {
    $xamarinUtilsPath = "$PSScriptRoot/../provision/utils/xamarin-utils.sh"
    return Invoke-Expression "bash -c `"source $xamarinUtilsPath && $FunctionName $parameter`""
}

Describe "Toolset JSON validation" {
    $toolsets | ForEach-Object {
        It "$($_.Name) is valid" {
            $jsonContent = Get-Content -Raw $_.Fullname
            $jsonContent | Test-Json | Should -BeTrue
        }
    }
}

$toolsets | ForEach-Object {
    Describe "$($_.Name)" {
        $toolset = Get-Content -Raw $_.Fullname | ConvertFrom-Json

        Context "Xcode" {
            It "Default Xcode should be defined" {
                $toolset.xcode.default | Should -BeTrue
            }

            It "Default Xcode is listed in Xcode list" {
                $toolset.xcode.versions | Should -Contain $toolset.xcode.default
            }
        }

        Context "VSMac" {
            $vsmacVersion = $toolset.xamarin.vsmac

            It "Version '$vsmacVersion' is available and can be downloaded" {
                $vsmacUrl = Invoke-BashUtilsFunction("buildVSMacDownloadUrl", $vsmacVersion)
                Validate-Url $vsmacUrl
            }
        }

        Context "Mono" {
            $sdkVersions = $toolset.xamarin."mono-versions"

            $sdkVersions | ForEach-Object {
                It "Version '$_' is available and can be downloaded" {
                    $sdkUrl = Invoke-BashUtilsFunction("buildMonoDownloadUrl", $_)
                    Validate-Url $sdkUrl
                }
            }

            It "Version list doesn't contain versions with the same major/minor version" {
                $versions = $sdkVersions | ForEach-Object { Get-ShortVersion $_ }
                Validate-ArrayWithoutDuplicates $versions -Because "It doesn't allow to install more than one version with the same major/minor"
            }
        }

        Context "Xamarin.iOS" {
            $sdkVersions = $toolset.xamarin."ios-versions"

            $sdkVersions | ForEach-Object {
                It "Version '$_' is available and can be downloaded" {
                    $sdkUrl = Invoke-BashUtilsFunction("buildXamariniIOSDownloadUrl", $_)
                    Validate-Url $sdkUrl
                }
            }

            It "Version list doesn't contain versions with the same major/minor version" {
                $versions = $sdkVersions | ForEach-Object { Get-ShortVersion $_ }
                Validate-ArrayWithoutDuplicates $versions -Because "It doesn't allow to install more than one version with the same major/minor"
            }
        }

        Context "Xamarin.Mac" {
            $sdkVersions = $toolset.xamarin."mac-versions"

            $sdkVersions | ForEach-Object {
                It "Version '$_' is available and can be downloaded" {
                    $sdkUrl = Invoke-BashUtilsFunction("buildXamarinMacDownloadUrl", $_)
                    Validate-Url $sdkUrl
                }
            }

            It "Version list doesn't contain versions with the same major/minor version" {
                $versions = $sdkVersions | ForEach-Object { Get-ShortVersion $_ }
                Validate-ArrayWithoutDuplicates $versions -Because "It doesn't allow to install more than one version with the same major/minor"
            }
        }

        Context "Xamarin.Android" {
            $sdkVersions = $toolset.xamarin."android-versions"

            $sdkVersions | ForEach-Object {
                It "Version '$_' is available and can be downloaded" {
                    $sdkUrl = Invoke-BashUtilsFunction("buildXamarinAndroidDownloadUrl", $_)
                    Validate-Url $sdkUrl
                }
            }

            It "Version list doesn't contain versions with the same major/minor version" {
                $versions = $sdkVersions | ForEach-Object { $_.Replace("-", ".") } | ForEach-Object { Get-ShortVersion $_ }
                Validate-ArrayWithoutDuplicates $versions -Because "It doesn't allow to install more than one version with the same major/minor"
            }
        }

        Context "Xamarin bundles" {
            $monoVersions = $toolset.xamarin."mono-versions" | ForEach-Object { Get-ShortVersion $_ }
            $iOSVersions = $toolset.xamarin."ios-versions" | ForEach-Object { Get-ShortVersion $_ }
            $macVersions = $toolset.xamarin."mac-versions" | ForEach-Object { Get-ShortVersion $_ }
            # Old Xamarin.Android version looks like "9.0.0-18" that doesn't support by System.Version
            $androidVersions = $toolset.xamarin."android-versions" | ForEach-Object { Get-ShortVersion $_.Replace("-", ".") }
            

            $bundles = $toolset.xamarin.bundles
            $bundles | ForEach-Object {
                It "'$($_.symlink)' is valid" {
                    $monoVersions | Should -Contain $_.mono
                    $iOSVersions | Should -Contain $_.ios
                    $macVersions | Should -Contain $_.mac
                    $androidVersions | Should -Contain $_.android
                }
            }

            It "Each bundle has unique symlink" {
                $symlinks = $bundles | ForEach-Object { $_.symlink }
                Validate-ArrayWithoutDuplicates $symlinks -Because "Bundle symlinks should be unique"
            }

            It "Current bundle is valid" {
                $currentBundleSymlink = $toolset.xamarin."bundle-default"
                if ($currentBundleSymlink -ne "latest") {
                    $bundleSymlinks = $bundles | ForEach-Object { $_.symlink }
                    $bundleSymlinks | Should -Contain $currentBundleSymlink -Because "Current bundle should be installed"
                }
                
            }

        }
    }
}