Describe "Vsix" {
    $toolset = Get-ToolsetContent
    $requiredVsixs = $toolset.visualStudio.vsix

    $allPackages = (Get-VSSetupInstance | Select-VsSetupInstance -Product *).Packages
    $testCases = $requiredVsixs | ForEach-Object { @{ VsixId = $_.Id;  AllPackages = $allPackages }}
    if ($testCases.Count -gt 0) {
        It "Extension <VsixId>" -TestCases $testCases {
            $objVsix = $AllPackages | Where-Object { $_.id -eq $VsixId }
            $objVsix | Should -Not -BeNullOrEmpty
        }
    }
}