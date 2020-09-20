BeforeAll {
    $msys2BinDir = "C:\msys64\usr\bin"
    $msys2mingwDir = "C:\msys64\mingw64\bin"
}

Describe "MSYS2" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bash.exe" }
        @{ ToolName = "tar.exe" }
        @{ ToolName = "make.exe" }
    ) {
        Join-Path $msys2BinDir $ToolName | Should -Exist
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "gcc.exe" }
        @{ ToolName = "cmake.exe" }
        @{ ToolName = "g++.exe" }
        @{ ToolName = "clang-tidy.exe" }
    ) {
        Join-Path $msys2mingwDir $ToolName | Should -Exist
    }
}