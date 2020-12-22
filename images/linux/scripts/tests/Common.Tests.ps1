Describe "Haskell" {

    $GHCCommonPath = "/opt/ghc"
    $GHCVersions = Get-ChildItem -Path $GHCCommonPath | Where-Object { $_.Name -match "\d+\.\d+" }
    
    $testCases = $GHCVersions | ForEach-Object { @{ GHCPath = "${_}/bin/ghc"} }
    
    It "Number of Installed GHC versions" {
        ($GHCVersions.Count) | Should -Be 3
    }

    It "GHC version <GHCPath>" -TestCases $testCases {
            param ([string] $GHCPath)
            "$GHCPath --version" | Should -ReturnZeroExitCode
    }

    It "Default GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}