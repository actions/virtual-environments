Describe "WindowsFeatures" {

    $testCases = @(
        @{ FeatureName = "NET-Framework-Features" }
        @{ FeatureName = "NET-Framework-45-Features" }
        @{ FeatureName = "FS-iSCSITarget-Server" }
    )

    if (Test-isWin16) {
        $testCases += @{ FeatureName = "BITS" }
        $testCases += @{ FeatureName = "DSC-Service" }
    }
    if (Test-isWin19) {
        $testCases += @{ FeatureName = "Microsoft-Windows-Subsystem-Linux" }
    }

    It "Windows Feature <FeatureName> is installed" -TestCases $testCases {
        (Get-WindowsFeature -Name $FeatureName).InstallState | Should -Be "Installed"
    }

    if (Test-isWin19) {
        it "Check WSL is on path" {
            (Get-Command -Name 'wsl') | Should -ReturnZeroExitCode
        }
    }
}

Describe "ContainersFeature" {
    It "Windows containers feature is installed" {
        (Get-WindowsFeature -Name "Containers").InstallState | Should -Be "Installed"
    }
}
