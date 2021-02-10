Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$os = Get-OSVersion

Describe "Linters" {
    It "yamllint" {
        "yamllint --version" | Should -ReturnZeroExitCode
    }

    It "SwiftLint" -Skip:($os.IsHighSierra) {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}