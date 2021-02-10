Describe "Haskell" {
    $chocoPackagesPath = Join-Path $env:ChocolateyInstall "lib"
    [array]$ghcVersionList = Get-ChildItem -Path $chocoPackagesPath -Filter "ghc.*" | ForEach-Object { $_.Name.TrimStart("ghc.") }
    $ghcCount = $ghcVersionList.Count
    $defaultGhcVersion = $ghcVersionList | Sort-Object {[Version]$_} | Select-Object -Last 1

    $ghcTestCases = $ghcVersionList | ForEach-Object {
        $ghcVersion = $_
        @{
            ghcVersion = $ghcVersion
            binGhcPath = Join-Path $chocoPackagesPath "ghc.$ghcVersion\tools\ghc-$ghcVersion\bin\ghc.exe"
        }
    }

    It "Accurate 3 versions of GHC are installed" -TestCases @{ghcCount = $ghcCount} {
        $ghcCount | Should -BeExactly 3
    }

    It "GHC <ghcVersion> is installed" -TestCases $ghcTestCases {
        "$binGhcPath --version" | Should -MatchCommandOutput $ghcVersion
    }

    It "GHC <defaultGhcVersion> is the default version and should be the latest installed" -TestCases @{defaultGhcVersion = $defaultGhcVersion} {
        "ghc --version" | Should -MatchCommandOutput $defaultGhcVersion
    }

    It "Cabal is installed" {
        "cabal --version" | Should -ReturnZeroExitCode
    }
}