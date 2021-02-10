Describe "Java" {
    It "Java <DefaultJavaVersion> is default" -TestCases @(@{ DefaultJavaVersion = 8 }) {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_X64"

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
        @{ ToolName = "gradle" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    It "Java <Version>" -TestCases @(
        @{ Version = "1.7" }
        @{ Version = "1.8" }
        @{ Version = "11" }
        @{ Version = "13" }
    ) {
        $versionNumber = $version.Split(".") | Select-Object -Last 1

        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${versionNumber}_X64"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin\java"

        $result = Get-CommandResult "`"$javaPath`" -version"
        $result.ExitCode | Should -Be 0
        $result.Output[0] | Should -Match ([regex]::Escape("openjdk version `"${Version}."))
    }
}