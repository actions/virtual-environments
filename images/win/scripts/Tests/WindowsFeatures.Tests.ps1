Describe "WindowsNETFeatures" {

    $testCases = @(
        @{ FeatureName = "NET-Framework-Features" }
        @{ FeatureName = "NET-Framework-45-Features" }
        @{ FeatureName = "FS-iSCSITarget-Server" }
    )

    if (Test-isWin16) {
        $testCases += @{ FeatureName = "BITS" }
        $testCases += @{ FeatureName = "DSC-Service" }
    }

    It "Windows NET Feature <FeatureName> is installed" -TestCases $testCases {
        (Get-WindowsFeature -Name $FeatureName).InstallState | Should -Be "Installed"
    }


}

Describe "ContainersFeature" {
    It "Windows containers feature is installed" {
        (Get-WindowsFeature -Name "Containers").InstallState | Should -Be "Installed"
    }
}