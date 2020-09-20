Describe "WDK" {
    It "WDK exists" {
      $WDKVersion = (Get-CimInstance -ClassName Win32_Product -Filter "Name = 'Windows Driver Kit'").Version
      $WDKVersion| Should -Not -BeNullOrEmpty
    }

    It "WDK version from system" {
      $version = Get-VSExtensionVersion -packageName "Microsoft.Windows.DriverKit"
      $version | Should -Not -BeNullOrEmpty
    }
}
