Describe "Node.JS" {
    Context "Basic modules"{
        It "<ToolName> " -TestCases @(
            @{ ToolName = "node" }
            @{ ToolName = "npm" }
        ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }
    Context "Global NPM Packages" {
        It "<ToolName> " -TestCases @(
            @{ ToolName = "gulp" }
            @{ ToolName = "grunt" }
            @{ ToolName = "yarn" }
            @{ ToolName = "lerna" }
            @{ ToolName = "newman" }
        ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }
}