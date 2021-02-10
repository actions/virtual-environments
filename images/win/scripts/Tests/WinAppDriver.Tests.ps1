Describe "WinAppDriver" {
  It "WinAppDriver directory exists" {
    Test-Path -Path "${env:ProgramFiles(x86)}\Windows Application Driver" | Should -BeTrue
  }

  It "Developer Mode is enabled" {
    $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock";
    Get-ItemProperty -Path $path | Select-Object -ExpandProperty "AllowDevelopmentWithoutDevLicense" | Should -Be 1
  }
}
