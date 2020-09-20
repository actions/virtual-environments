Describe "PHP" {
    It "Check <ToolName> in the PATH" -TestCases @(
        @{ ToolName = "php" }
        @{ ToolName = "composer" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }

    It "PHP Environment variables is set." {
        ${env:PHPROOT} | Should -Not -BeNullOrEmpty
        ${env:PHPROOT} | Should -Exist
    }
}