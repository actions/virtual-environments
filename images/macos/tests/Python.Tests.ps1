Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Python" {
    It "Python 2 is available" {
        "python --version" | Should -ReturnZeroExitCode
    }

    It "Python 2 is real 2.x" {
        (Get-CommandResult "python --version").Output | Should -BeLike "Python 2.*"
    }

    It "Python 2 is installed under /usr/local/bin" {
        Get-WhichTool "python" | Should -BeLike "/usr/local/bin*"
    }

    It "Python 3 is available" {
        "python3 --version" | Should -ReturnZeroExitCode
    }

    It "Python 3 is installed under /usr/local/bin" {
        Get-WhichTool "python3" | Should -BeLike "/usr/local/bin*"
    }

    It "Pip 2 is available" {
        "pip --version" | Should -ReturnZeroExitCode
    }

    It "Pip 3 is available" {
        "pip3 --version" | Should -ReturnZeroExitCode
    }
}