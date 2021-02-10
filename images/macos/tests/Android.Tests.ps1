Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"
Import-Module "$PSScriptRoot/../software-report/SoftwareReport.Android.psm1"

$os = Get-OSVersion

Describe "Android" {
    $androidNdkToolchains = @("mips64el-linux-android-4.9", "mipsel-linux-android-4.9")
    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
    [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"

    $platforms = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;', '' |
    Where-Object { [int]$_.Split("-")[1] -ge $platformMinVersion } | Sort-Object { [int]$_.Split("-")[1] } -Unique |
    ForEach-Object { "platforms/${_}" })

    $buildTools = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', '' |
    Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object { [version]$_ } -Unique |
    ForEach-Object { "build-tools/${_}" })

    $androidPackages = @(
        "tools",
        "platform-tools",
        "tools/proguard",
        "ndk-bundle",
        "cmake",
        $platforms,
        $buildTools,
        (Get-ToolsetValue "android.extra-list" | ForEach-Object { "extras/${_}" }),
        (Get-ToolsetValue "android.addon-list" | ForEach-Object { "add-ons/${_}" })
    ) | ForEach-Object { $_ }

    BeforeAll {
        $ANDROID_SDK_DIR = Join-Path $env:HOME "Library" "Android" "sdk"

        function Validate-AndroidPackage {
            param (
                [Parameter(Mandatory=$true)]
                [string]$PackageName
            )

            # Convert 'm2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1' ->
            #         'm2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta1'
            $PackageName = $PackageName.Replace(";", "/")
            $targetPath = Join-Path $ANDROID_SDK_DIR $PackageName
            $targetPath | Should -Exist
        }
    }


    Context "Packages" {
        $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }

        It "<PackageName>" -TestCases $testCases {
            param ([string] $PackageName)
            Validate-AndroidPackage $PackageName
        }
    }

    Context "NDK toolchains" -Skip:($os.IsBigSur) {
        $testCases = $androidNdkToolchains | ForEach-Object { @{AndroidNdkToolchain = $_} }

        It "<AndroidNdkToolchain>" -TestCases $testCases {
            param ([string] $AndroidNdkToolchain)

            $toolchainPath = Join-Path $ANDROID_SDK_DIR "ndk-bundle" "toolchains" $AndroidNdkToolchain
            $toolchainPath | Should -Exist
        }
    }

    Context "Legacy NDK versions" -Skip:($os.IsBigSur) {
        It "Android NDK version is 21" {
            $ndkBundlePath = Join-Path $ANDROID_SDK_DIR "ndk-bundle" "source.properties"
            $rawContent = Get-Content $ndkBundlePath -Raw
            $rawContent | Should -BeLikeExactly "*Revision = 21.*"
        }

        It "Android NDK version r18b is installed" {
            $ndk18BundlePath = Join-Path $ANDROID_SDK_DIR "ndk" "18.1.5063045" "source.properties"
            $rawContent = Get-Content $ndk18BundlePath -Raw
            $rawContent | Should -BeLikeExactly "*Revision = 18.*"
        }
    }

    It "HAXM is installed" {
        $haxmPath = Join-Path $ANDROID_SDK_DIR "extras" "intel" "Hardware_Accelerated_Execution_Manager" "silent_install.sh"
        "$haxmPath -v" | Should -ReturnZeroExitCode
    }
}

Describe "Gradle" {
    It "Gradle is installed" {
        "gradle --version" | Should -ReturnZeroExitCode
    }

    It "Gradle is installed to /usr/local/bin" {
        (Get-Command "gradle").Path | Should -BeExactly "/usr/local/bin/gradle"
    }

    It "Gradle is compatible with init.d plugins" {
        "cd /tmp && gradle tasks" | Should -ReturnZeroExitCode
    }
}