Describe "Miniconda" {
    It "Miniconda Environment variables is set. " {
        ${env:CONDA} | Should -Not -BeNullOrEmpty
    }
    
    It "Miniconda $env:CONDA\<PathTest> " -TestCases @(
        @{ PathTest = "python.exe" }
        @{ PathTest = "Scripts\conda.exe" }
    ) {
        $condaPath = Join-Path ${env:CONDA} $PathTest
        $condaPath | Should -Exist
        "$condaPath --version" | Should -ReturnZeroExitCode
    }
}