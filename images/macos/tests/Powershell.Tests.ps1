Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Powershell" {
    It "Powershell is installed" {
        "pwsh -v" | Should -ReturnZeroExitCode
    }

    Context "Powershell Modules" {
        $modules = Get-ToolsetValue powershellModules
        $withoutVersionsModules = $modules | Where-Object {-not $_.versions} | ForEach-Object {
            @{moduleName = $_.name}
        }

        $withVersionsModules = $modules | Where-Object {$_.versions} | ForEach-Object {
            $moduleName = $_.name
            $_.versions | ForEach-Object {
                @{moduleName = $moduleName; expectedVersion = $_}
            }
        }
    
        It "<moduleName> is installed" -TestCases $withoutVersionsModules {
            param (
                [string] $moduleName
            )

            Get-Module -Name $moduleName -ListAvailable | Should -BeTrue
        }
    
        if ($withVersionsModules) {
            It "<moduleName> with <expectedVersion> is installed" -TestCases $withVersionsModules {
                param (
                    [string] $moduleName,
                    [string] $expectedVersion
                )

                (Get-Module -Name $moduleName -ListAvailable).Version -contains $expectedVersion | Should -BeTrue
            }
        }
    }
}