Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$MONO_VERSIONS = Get-ToolsetValue "xamarin.mono-versions"
$XAMARIN_IOS_VERSIONS = Get-ToolsetValue "xamarin.ios-versions"
$XAMARIN_MAC_VERSIONS = Get-ToolsetValue "xamarin.mac-versions"
$XAMARIN_ANDROID_VERSIONS = Get-ToolsetValue "xamarin.android-versions"

BeforeAll {
    function Get-ShortSymlink {
        param (
            [string] $Version
        )
        
        $versionParts = $Version.Split(".")
        return [String]::Join(".", $versionParts[0..1])
    }
}

Describe "Mono" {
    $MONO_VERSIONS | ForEach-Object {
        Context "$_" {
            $MONO_VERSIONS_PATH = "/Library/Frameworks/Mono.framework/Versions"
            $versionFolderPath = Join-Path $MONO_VERSIONS_PATH ([System.Version]::Parse($_).ToString(3))
            $testCase = @{ MonoVersion = $_; VersionFolderPath = $versionFolderPath; MonoVersionsPath = $MONO_VERSIONS_PATH }

            It "is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )

                $monoBinPath = Join-Path $VersionFolderPath "bin" "mono"
                $VersionFolderPath | Should -Exist
                $monoBinPath | Should -Exist
            }

            It "is available via short link" -TestCases $testCase {
                param (
                    [string] $MonoVersion,
                    [string] $MonoVersionsPath,
                    [string] $VersionFolderPath
                )

                $shortSymlink = Get-ShortSymlink $MonoVersion # only 'major.minor'
                $shortSymlinkFolderPath = Join-Path $MonoVersionsPath $shortSymlink
                if ($shortSymlink -eq "4.8") { return } # Skip this test for Mono 4.8 because it doesn't contain VERSION file
                $shortVersionPath = Join-Path $shortSymlinkFolderPath "VERSION"
                $fullVersionPath = Join-Path $VersionFolderPath "VERSION"

                Validate-IdenticalFileContent -File1 $shortVersionPath -File2 $fullVersionPath
            }

            It "NUnit console is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )

                $nunitPath = Join-Path $VersionFolderPath "Commands" "nunit3-console"
                $nunitPath | Should -Exist
            }

            It "Nuget is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )

                $nugetBinaryPath = Join-Path $VersionFolderPath "lib" "mono" "nuget" "nuget.exe"
                $nugetBinaryWrapperPath = Join-Path $VersionFolderPath "bin" "nuget"
                $nugetCommandPath = Join-Path $VersionFolderPath "Commands" "nuget"

                $nugetBinaryPath | Should -Exist
                $nugetCommandPath | Should -Exist
                $nugetBinaryWrapperPath | Should -Exist
            }

            It "Nuget is valid" -TestCases $testCase {
                param ( [string] $VersionFolderPath )

                $nugetBinaryWrapperPath = Join-Path $VersionFolderPath "bin" "nuget"
                "$nugetBinaryWrapperPath" | Should -ReturnZeroExitCode
            }
        }
    }
}

Describe "Xamarin.iOS" {  
    $XAMARIN_IOS_VERSIONS | ForEach-Object {
        Context "$_" {
            $XAMARIN_IOS_VERSIONS_PATH = "/Library/Frameworks/Xamarin.iOS.framework/Versions"
            $versionFolderPath = Join-Path $XAMARIN_IOS_VERSIONS_PATH $_
            $testCase = @{ XamarinIosVersion = $_; VersionFolderPath = $versionFolderPath; IosVersionsPath = $XAMARIN_IOS_VERSIONS_PATH }

            It "is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )
         
                $xamarinBinPath = Join-Path $VersionFolderPath "bin"
                $VersionFolderPath | Should -Exist
                $xamarinBinPath | Should -Exist
            }
        
            It "is available via short link" -TestCases $testCase {
                param (
                    [string] $XamarinIosVersion,
                    [string] $IosVersionsPath,
                    [string] $VersionFolderPath
                )
 
                $shortSymlink = Get-ShortSymlink $XamarinIosVersion # only 'major.minor'
                $shortSymlinkFolderPath = Join-Path $IosVersionsPath $shortSymlink
                $shortVersionPath = Join-Path $shortSymlinkFolderPath "VERSION"
                $fullVersionPath = Join-Path $VersionFolderPath "VERSION"
        
                Validate-IdenticalFileContent -File1 $shortVersionPath -File2 $fullVersionPath
            }
        }
    }    
}

Describe "Xamarin.Mac" {
    $XAMARIN_MAC_VERSIONS | ForEach-Object {
        Context "$_" {
            $XAMARIN_MAC_VERSIONS_PATH = "/Library/Frameworks/Xamarin.Mac.framework/Versions"
            $versionFolderPath = Join-Path $XAMARIN_MAC_VERSIONS_PATH $_
            $testCase = @{ XamarinMacVersion = $_; VersionFolderPath = $versionFolderPath; MacVersionsPath = $XAMARIN_MAC_VERSIONS_PATH  }
            
            It "is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )

                $xamarinBinPath = Join-Path $VersionFolderPath "bin"
                $VersionFolderPath | Should -Exist
                $xamarinBinPath | Should -Exist
            }
        
            It "is available via short link" -TestCases $testCase {
                param (
                    [string] $XamarinMacVersion,
                    [string] $MacVersionsPath,
                    [string] $VersionFolderPath
                )

                $shortSymlink = Get-ShortSymlink $XamarinMacVersion # only 'major.minor'
                $shortSymlinkFolderPath = Join-Path $MacVersionsPath $shortSymlink
                $shortVersionPath = Join-Path $shortSymlinkFolderPath "VERSION"
                $fullVersionPath = Join-Path $VersionFolderPath "VERSION"
        
                Validate-IdenticalFileContent -File1 $shortVersionPath -File2 $fullVersionPath
            }
        }
    }
}

Describe "Xamarin.Android" {
    $XAMARIN_ANDROID_VERSIONS | ForEach-Object {
        Context "$_" {
            $XAMARIN_ANDROID_VERSIONS_PATH = "/Library/Frameworks/Xamarin.Android.framework/Versions"
            $versionFolderPath = Join-Path $XAMARIN_ANDROID_VERSIONS_PATH $_
            $testCase = @{ XamarinAndroidVersion = $_; VersionFolderPath = $versionFolderPath; AndroidVersionsPath = $XAMARIN_ANDROID_VERSIONS_PATH }

            It "is installed" -TestCases $testCase {
                param ( [string] $VersionFolderPath )
                
                $xamarinLibPath = Join-Path $VersionFolderPath "lib"
                $xamarinLibPath | Should -Exist
            }
        
            It "is available via short link" -TestCases $testCase {
                param (
                    [string] $XamarinAndroidVersion,
                    [string] $AndroidVersionsPath,
                    [string] $VersionFolderPath
                )
                
                $shortSymlink = Get-ShortSymlink $XamarinAndroidVersion # only 'major.minor'
                $shortSymlinkFolderPath = Join-Path $AndroidVersionsPath $shortSymlink
                $shortVersionPath = Join-Path $shortSymlinkFolderPath "VERSION"
                $fullVersionPath = Join-Path $VersionFolderPath "VERSION"
        
                Validate-IdenticalFileContent -File1 $shortVersionPath -File2 $fullVersionPath
            }
        
            It "has correct symlinks" -TestCases $testCase {
                param ( [string] $VersionFolderPath )
                
                $xamarinLibPath = Join-Path $VersionFolderPath "lib"
                Join-Path $xamarinLibPath "xbuild" | Should -Exist
                Join-Path $xamarinLibPath "xbuild-frameworks" | Should -Exist
            }   
        }
    }       
}

Describe "Xamarin Bundles" {
    BeforeAll {
        $MONO_VERSIONS_PATH = "/Library/Frameworks/Mono.framework/Versions"
        $XAMARIN_IOS_VERSIONS_PATH = "/Library/Frameworks/Xamarin.iOS.framework/Versions"
        $XAMARIN_MAC_VERSIONS_PATH = "/Library/Frameworks/Xamarin.Mac.framework/Versions"
        $XAMARIN_ANDROID_VERSIONS_PATH = "/Library/Frameworks/Xamarin.Android.framework/Versions"
    }
    
    [array]$XAMARIN_BUNDLES = Get-ToolsetValue "xamarin.bundles"
    $XAMARIN_DEFAULT_BUNDLE = Get-ToolsetValue "xamarin.bundle-default"
    If ($XAMARIN_DEFAULT_BUNDLE -eq "latest") { $XAMARIN_DEFAULT_BUNDLE = $XAMARIN_BUNDLES[0].symlink }
    
    $currentBundle = [PSCustomObject] @{
        symlink = "Current"
        mono = $XAMARIN_DEFAULT_BUNDLE
        ios = $XAMARIN_DEFAULT_BUNDLE
        mac = $XAMARIN_DEFAULT_BUNDLE
        android = $XAMARIN_DEFAULT_BUNDLE
    }

    $latestBundle = [PSCustomObject] @{
        symlink = "Latest"
        mono = $XAMARIN_BUNDLES[0].mono
        ios = $XAMARIN_BUNDLES[0].ios
        mac = $XAMARIN_BUNDLES[0].mac
        android = $XAMARIN_BUNDLES[0].android
    }

    $bundles = $XAMARIN_BUNDLES + $currentBundle + $latestBundle
    $allBundles = $bundles | ForEach-Object { @{BundleSymlink = $_.symlink; BundleMono = $_.mono; BundleIos = $_.ios; BundleMac = $_.mac; BundleAndroid = $_.android} }

    It "Mono symlink <BundleSymlink> exists" -TestCases $allBundles {
        param ( [string] $BundleSymlink )
        
        (Join-Path $MONO_VERSIONS_PATH $BundleSymlink) | Should -Exist
    }

    It "Mono symlink <BundleSymlink> points to the correct version" -TestCases $allBundles {
        param (
            [string] $BundleSymlink,
            [string] $BundleMono
        )

        if ($BundleMono -eq "4.8") { return } # Skip this test for Mono 4.8 because it doesn't contain VERSION file
        $sourceVersionPath = Join-Path $MONO_VERSIONS_PATH $BundleMono "VERSION"
        $targetVersionPath = Join-Path $MONO_VERSIONS_PATH $BundleSymlink "VERSION"

        Validate-IdenticalFileContent -File1 $targetVersionPath -File2 $sourceVersionPath
    }

    It "iOS symlink <BundleSymlink> exists" -TestCases $allBundles {
        param ( [string] $BundleSymlink )

        (Join-Path $XAMARIN_IOS_VERSIONS_PATH $BundleSymlink) | Should -Exist
    }

    It "iOS symlink <BundleSymlink> points to the correct version" -TestCases $allBundles {
        param (
            [string] $BundleSymlink,
            [string] $BundleIos
        )

        $sourceVersionPath = Join-Path $XAMARIN_IOS_VERSIONS_PATH $BundleIos "VERSION"
        $targetVersionPath = Join-Path $XAMARIN_IOS_VERSIONS_PATH $BundleSymlink "VERSION"

        Validate-IdenticalFileContent -File1 $targetVersionPath -File2 $sourceVersionPath
    }

    It "Mac symlink <BundleSymlink> exists" -TestCases $allBundles {
        param ( [string] $BundleSymlink )

        (Join-Path $XAMARIN_MAC_VERSIONS_PATH $BundleSymlink) | Should -Exist
    }

    It "Mac symlink <BundleSymlink> points to the correct version" -TestCases $allBundles {
        param (
            [string] $BundleSymlink,
            [string] $BundleMac
        )

        $sourceVersionPath = Join-Path $XAMARIN_MAC_VERSIONS_PATH $BundleMac "VERSION"
        $targetVersionPath = Join-Path $XAMARIN_MAC_VERSIONS_PATH $BundleSymlink "VERSION"

        Validate-IdenticalFileContent -File1 $targetVersionPath -File2 $sourceVersionPath
    }

    It "Xamarin.Android symlink <BundleSymlink> exists" -TestCases $allBundles {
        param ( [string] $BundleSymlink )

        (Join-Path $XAMARIN_ANDROID_VERSIONS_PATH $BundleSymlink) | Should -Exist
    }

    It "Android symlink <BundleSymlink> points to the correct version" -TestCases $allBundles {
        param (
            [string] $BundleSymlink,
            [string] $BundleAndroid
        )

        $sourceVersionPath = Join-Path $XAMARIN_ANDROID_VERSIONS_PATH $BundleAndroid "VERSION"
        $targetVersionPath = Join-Path $XAMARIN_ANDROID_VERSIONS_PATH $BundleSymlink "VERSION"

        Validate-IdenticalFileContent -File1 $targetVersionPath -File2 $sourceVersionPath
    }
}