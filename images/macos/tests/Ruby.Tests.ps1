Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Ruby" {
    It "Ruby is available" {
        "ruby --version" | Should -ReturnZeroExitCode
    }

    It "Ruby is installed via HomeBrew" {
        Get-WhichTool "ruby" | Should -Not -BeLike "/usr/bin/ruby*"
    }

    It "Ruby tools are consistent" {
        $expectedPrefix = "/usr/local"
        Get-WhichTool "ruby" | Should -Match "$($expectedPrefix)*"
        Get-WhichTool "gem" | Should -Match "$($expectedPrefix)*"
        Get-WhichTool "bundler" | Should -Match "$($expectedPrefix)*"
    }

    It "Ruby gems permissions are valid" {
        "gem install bundle" | Should -ReturnZeroExitCode
        "gem uninstall bundle" | Should -ReturnZeroExitCode
    }
}