Describe "Rust" {
    $rustTools = @(
        @{ToolName = "rustup"; binPath = "C:\Rust\.cargo\bin\rustup.exe"}
        @{ToolName = "rustc"; binPath = "C:\Rust\.cargo\bin\rustc.exe"}
        @{ToolName = "cargo"; binPath = "C:\Rust\.cargo\bin\cargo.exe"}
        @{ToolName = "cargo audit"; binPath = "C:\Rust\.cargo\bin\cargo-audit.exe"}
        @{ToolName = "cargo outdated"; binPath = "C:\Rust\.cargo\bin\cargo-outdated.exe"}
    )

    $rustEnvNotExists = @(
        @{envVar = "RUSTUP_HOME"}
        @{envVar = "CARGO_HOME"}
    )

    It "C:\Rust\.rustup and C:\Rust\.cargo folders exist" {
        "C:\Rust\.rustup", "C:\Rust\.cargo" | Should -Exist
    }

    It "<envVar> environment variable does not exist" -TestCases $rustEnvNotExists {
        [Environment]::GetEnvironmentVariables("Machine").ContainsKey($envVar) | Should -BeFalse
    }

    It "<ToolName> is installed to the '<binPath>' folder" -TestCases $rustTools {
        "$ToolName --version" | Should -ReturnZeroExitCode
        $binPath | Should -Exist
    }
}