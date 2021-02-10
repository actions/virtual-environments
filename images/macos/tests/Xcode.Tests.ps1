Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$XCODE_VERSIONS = Get-ToolsetValue "xcode.versions"
$DEFAULT_XCODE = Get-ToolsetValue "xcode.default"
$LATEST_XCODE_VERSION = $XCODE_VERSIONS | Select-Object -First 1
$OS = Get-OSVersion

Describe "Xcode" {
    It "Default Xcode is $DEFAULT_XCODE" {
        "xcodebuild -version" | Should -ReturnZeroExitCode
        (Get-CommandResult "xcodebuild -version").Output | Should -BeLike "Xcode $DEFAULT_XCODE*"
    }

    # Cut "_beta" postfix for test cases
    $testCases = $XCODE_VERSIONS | ForEach-Object { @{XcodeVersion = $_.Split("_")[0] } }

    It "<XcodeVersion>" -TestCases $testCases {
        param ( [string] $XcodeVersion )

        $xcodebuildPath = Get-XcodeToolPath -Version $XcodeVersion -ToolName "xcodebuild"
        "$xcodebuildPath -version" | Should -ReturnZeroExitCode
    }

    It "Xcode <XcodeVersion> tools are installed" -TestCases $testCases -Skip:($os.IsHighSierra) {
        param ( [string] $XcodeVersion )

        $TOOLS_NOT_INSTALLED_EXIT_CODE = 69
        $xcodebuildPath = Get-XcodeToolPath -Version $XcodeVersion -ToolName "xcodebuild"
        $result = Get-CommandResult "$xcodebuildPath -checkFirstLaunchStatus"

        if ($XcodeVersion -ne $LATEST_XCODE_VERSION) {
            $result.ExitCode | Should -Not -Be $TOOLS_NOT_INSTALLED_EXIT_CODE
        } else {
            $result.ExitCode | Should -BeIn (0, $TOOLS_NOT_INSTALLED_EXIT_CODE)
        }
    }

    It "Xcode <XcodeVersion> has correct beta symlink" -TestCases $testCases {
        param ( [string] $XcodeVersion )

        $xcodesWithBetaSymlink = @("12", "9.3", "9.4")
        $shouldBetaSymlinkExists = $XcodeVersion.StartsWith("10") -or $XcodeVersion.StartsWith("11") -or ($XcodeVersion -in $xcodesWithBetaSymlink)

        $betaSymlinkPath = Get-XcodeRootPath -Version "${XcodeVersion}_beta"
        Test-Path $betaSymlinkPath | Should -Be $shouldBetaSymlinkExists
    }

    It "/Applications/Xcode* symlinks are valid" {
        $symlinks = Get-ChildItem "/Applications" -Filter "Xcode*" | Where-Object { $_.LinkType }

        $symlinks.Target | ForEach-Object {
            $_ | Should -Exist
        }
    }

    Context "XCODE_DEVELOPER_DIR" {
        $stableXcodeVersions = $XCODE_VERSIONS | ForEach-Object { $_.Split("_")[0] } | Where-Object { Test-XcodeStableRelease -Version $_ }
        $majorXcodeVersions = $stableXcodeVersions | ForEach-Object { $_.Split(".")[0] } | Select-Object -Unique
        $testCases = $majorXcodeVersions | ForEach-Object {
            $majorXcodeVersion = $_
            $expectedVersion = $stableXcodeVersions | Where-Object { $_.StartsWith("$majorXcodeVersion") } | Select-Object -First 1
            return @{
                MajorXcodeVersion = $majorXcodeVersion
                ExpectedVersion = $expectedVersion
            }
        }

        It "XCODE_<MajorXcodeVersion>_DEVELOPER_DIR" -TestCases $testCases {
            param (
                [string] $MajorXcodeVersion,
                [string] $ExpectedVersion
            )

            $variableName = "XCODE_${MajorXcodeVersion}_DEVELOPER_DIR"
            $actualPath = Get-EnvironmentVariable $variableName
            $expectedPath = Join-Path (Get-XcodeRootPath -Version $ExpectedVersion) "Contents/Developer"

            $actualPath | Should -Exist
            $actualPath | Should -Be $expectedPath
        }
    }
}

Describe "Xcode simulators" {
    $XCODE_VERSIONS | Where-Object { Test-XcodeStableRelease -Version $_ } | ForEach-Object {
        Switch-Xcode -Version $_

        Context "$_" {
            It "No duplicates in devices" {
                [array]$devicesList = @(Get-XcodeDevicesList | Where-Object { $_ })
                Validate-ArrayWithoutDuplicates $devicesList -Because "Found duplicate device simulators"
            }

            It "No duplicates in pairs" {
                [array]$pairsList = @(Get-XcodePairsList | Where-Object { $_ })
                Validate-ArrayWithoutDuplicates $pairsList -Because "Found duplicate pairs simulators"
            }
        }
    }

    AfterAll {
        $DEFAULT_XCODE = Get-ToolsetValue "xcode.default"
        Switch-Xcode -Version $DEFAULT_XCODE
    }
}