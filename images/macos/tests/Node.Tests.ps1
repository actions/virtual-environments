Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Node.JS" {
    BeforeAll {
        $os = Get-OSVersion
        $expectedNodeVersion = if ($os.IsHigherThanMojave) { "v12.*" } else { "v8.*" }
    }

    It "Node.JS is installed" {
        "node --version" | Should -ReturnZeroExitCode
    }

    It "Node.JS $expectedNodeVersion is default" {
        (Get-CommandResult "node --version").Output | Should -BeLike $expectedNodeVersion
    }

    It "NPM is installed" {
        "npm --version" | Should -ReturnZeroExitCode
    }

    It "Yarn is installed" {
        "yarn --version" | Should -ReturnZeroExitCode
    }
}

Describe "NVM" {
    BeforeAll {
        $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
        $nvmInitCommand = ". $nvmPath > /dev/null 2>&1 || true"
    }
    
    It "Nvm is installed" {
        $nvmPath | Should -Exist
        "$nvmInitCommand && nvm --version" | Should -ReturnZeroExitCode
    }

    Context "Nvm versions" {
        $NVM_VERSIONS = @(6, 8, 10, 12)
        $testCases = $NVM_VERSIONS | ForEach-Object { @{NvmVersion = $_} }

        It "<NvmVersion>" -TestCases $testCases {
            param (
                [string] $NvmVersion
            )
            
            "$nvmInitCommand && nvm ls $($NvmVersion)" | Should -ReturnZeroExitCode
        }
    }
}
