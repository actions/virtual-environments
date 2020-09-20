Describe "PowerShellModules" {
    $modules = (Get-ToolsetContent).powershellModules
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
        Get-Module -Name $moduleName -ListAvailable | Should -BeTrue
    }

    if ($withVersionsModules) {
        It "<moduleName> with <expectedVersion> is installed" -TestCases $withVersionsModules {
            (Get-Module -Name $moduleName -ListAvailable).Version -contains $expectedVersion | Should -BeTrue
        }
    }
}

Describe "AzureModules" {
    $modules = (Get-ToolsetContent).azureModules
    $modulesRootPath = $env:PSMODULES_ROOT_FOLDER

    foreach ($module in $modules) {
        $moduleName = $module.name

        Context "$moduleName" {

            foreach ($version in $module.versions) {
                $modulePath = Join-Path -Path $modulesRootPath -ChildPath "${moduleName}_${version}"
                $moduleInfo = @{ moduleName = $moduleName; modulePath = $modulePath; expectedVersion = $version }
                It "<expectedVersion> exists in modules directory" -TestCases $moduleInfo {
                    $testJob = Start-Job -ScriptBlock {
                        param (
                            $modulePath,
                            $moduleName
                        )

                        # Disable warning messages to prevent additional warnings about Az and Azurerm modules in the same session
                        $WarningPreference = "SilentlyContinue"

                        $env:PsModulePath = "$modulePath;$env:PsModulePath"
                        Import-Module -Name $moduleName
                        (Get-Module -Name $moduleName).Version.ToString()

                    } -ArgumentList $modulePath, $moduleName

                    $moduleVersion = $testJob | Wait-Job | Receive-Job
                    Remove-Job $testJob
                    $moduleVersion | Should -Match $expectedVersion
                }
            }

            if ($module.default) {
                $moduleInfo = @{ moduleName = $moduleName; moduleDefault = $module.default }
                It "<moduleDefault> set as default" -TestCases $moduleInfo {
                        $moduleVersion = (Get-Module -ListAvailable -Name $moduleName).Version.ToString()
                        $moduleVersion | Should -Match $moduleDefault
                }
            }
        }
    }
}