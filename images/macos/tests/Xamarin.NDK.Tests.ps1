Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"
Import-Module "$PSScriptRoot/../software-report/SoftwareReport.Android.psm1"

$os = Get-OSVersion

BeforeAll {
    $androidNdkToolchains = @("mips64el-linux-android-4.9", "mipsel-linux-android-4.9")
    $ANDROID_SDK_DIR = Join-Path $env:HOME "Library" "Android" "sdk"
}

Describe "Xamarin NDK" {
    Context "NDK toolchains" -Skip:($os.IsBigSur) {
        $testCases = $androidNdkToolchains | ForEach-Object { @{AndroidNdkToolchain = $_} }

        It "<AndroidNdkToolchain>" -TestCases $testCases {
            param ([string] $AndroidNdkToolchain)

            $toolchainPath = Join-Path $ANDROID_SDK_DIR "ndk-bundle" "toolchains" $AndroidNdkToolchain
            $toolchainPath | Should -Exist
        }
    }

    Context "Legacy NDK versions" -Skip:($os.IsBigSur) {
        It "Android NDK version r18b is installed" {
            $ndk18BundlePath = Join-Path $ANDROID_SDK_DIR "ndk" "18.1.5063045" "source.properties"
            $rawContent = Get-Content $ndk18BundlePath -Raw
            $rawContent | Should -BeLikeExactly "*Revision = 18.*"
        }
    }
}