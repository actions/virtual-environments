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
            (Get-Command -Name 'wsl') | Should -BeTrue
        }
    }
}

Describe "ContainersFeature" {
    It "Windows containers feature is installed" {
        (Get-WindowsFeature -Name "Containers").InstallState | Should -Be "Installed"
    }
}

Describe "DiskSpace" {
    It "The image has enough disk space"{
        $availableSpaceMB =  [math]::Round((Get-PSDrive -Name C).Free / 1MB)
        $minimumFreeSpaceMB = 18 * 1024

        $availableSpaceMB | Should -BeGreaterThan $minimumFreeSpaceMB
    }
}

Describe "DynamicPorts" {
    It "Test TCP dynamicport start=49152 num=16384" {
        $tcpPorts = Get-NetTCPSetting | Where-Object {$_.SettingName -ne "Automatic"} | Where-Object {
            $_.DynamicPortRangeStartPort -ne 49152 -or $_.DynamicPortRangeNumberOfPorts -ne 16384
        }

        $tcpPorts | Should -BeNullOrEmpty
    }

    It "Test UDP dynamicport start=49152 num=16384" {
        $udpPorts = Get-NetUDPSetting | Where-Object {
            $_.DynamicPortRangeStartPort -ne 49152 -or $_.DynamicPortRangeNumberOfPorts -ne 16384
        }

        $udpPorts | Should -BeNullOrEmpty
    }
}