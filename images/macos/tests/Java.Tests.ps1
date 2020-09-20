Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

#Java tests are disabled because Java is not working properly on macOS 11.0 yet.
$os = Get-OSVersion
function Get-NativeVersionFormat {
    param($Version)
    if ($Version -in "7", "8") {
        return "1.${Version}"
    }
    return $Version
}

Describe "Java" -Skip:($os.IsBigSur) {
    BeforeAll {
        function Validate-JavaVersion {
            param($JavaCommand, $ExpectedVersion)

            $commandResult = Get-CommandResult $JavaCommand
            $commandResult.ExitCode | Should -Be 0
            $matchResult = $commandResult.Output | Select-String '^openjdk version \"([\d\._]+)\"'
            $matchResult.Matches.Success | Should -BeTrue
            $version = $matchResult.Matches.Groups[1].Value
            $version | Should -BeLike "${ExpectedVersion}*"
        }
    }

    $versionsList = Get-ToolsetValue "java.versions"
    $defaultJava = Get-ToolsetValue "java.default"

    $testCases = $versionsList | ForEach-Object { @{ Title = $_; Version = (Get-NativeVersionFormat $_); EnvVariable = "JAVA_HOME_${_}_X64" } }
    $testCases += @{ Title = "Default"; Version = (Get-NativeVersionFormat $defaultJava); EnvVariable = "JAVA_HOME" }

    $testCases | ForEach-Object {
        Context $_.Title {
            It "Version is found by 'java_home'" -TestCases $_ {
                "/usr/libexec/java_home -v${Version}" | Should -ReturnZeroExitCode
            }

            It "Version is valid" -TestCases $_ {
                $javaRootPath = (Get-CommandResult "/usr/libexec/java_home -v${Version}").Output
                $javaBinPath = Join-Path $javaRootPath "/bin/java"
                Validate-JavaVersion -JavaCommand "$javaBinPath -version" -ExpectedVersion $Version
            }

            It "<EnvVariable>" -TestCases $_ {
                $envVariablePath = Get-EnvironmentVariable $EnvVariable
                $commandResult = Get-CommandResult "/usr/libexec/java_home -v${Version}"
                $commandResult.ExitCode | Should -Be 0
                $commandResult.Output | Should -Not -BeNullOrEmpty
                $commandResult.Output | Should -Be $envVariablePath
            }

            if ($_.Title -eq "Default") {
                It "Version is default" -TestCases $_ {
                    Validate-JavaVersion -JavaCommand "java -version" -ExpectedVersion $Version
                }
            }
        }
    }
}