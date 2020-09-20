Describe "SSDTExtensions" {
#These extensions don't have any proper name in the state.packages.json file, only id is available, which can be found on extension marketplace download page

    if (Test-isWin19) {
      $testExtenions = @(
      @{id = "04a86fc2-dbd5-4222-848e-911638e487fe"}
      @{id = "851E7A09-7B2B-4F06-A15D-BABFCB26B970"}
      @{id = "717ad572-c4b7-435c-c166-c2969777f718"}
      )

      It "Extensions id=<id>" -TestCases $testExtenions {
        $version = Get-VSExtensionVersion -packageName "${id}"
        $version | Should -Not -BeNullOrEmpty
      }
    } else {
      It "Extension SSDT" {
        $version = Get-VSExtensionVersion -packageName "SSDT"
        $version | Should -Not -BeNullOrEmpty
      }
    }
}
