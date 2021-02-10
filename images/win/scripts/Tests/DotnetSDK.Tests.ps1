$releaseIndexUrl = "https://raw.githubusercontent.com/dotnet/core/master/release-notes/releases-index.json"
$dotnetChannels = (New-Object system.net.webclient).DownloadString($releaseIndexUrl) | ConvertFrom-Json
$dotnetVersions = $dotnetChannels.'releases-index' | Where-Object { (!$_."support-phase".Equals('preview') -and !$_."support-phase".Equals('eol') -and !$_."support-phase".Equals('rc')) } | Select-Object -ExpandProperty "channel-version"

Describe "Dotnet SDK" {

    Context "Default" {
        It "Default Dotnet SDK is available" {
            "dotnet --version" | Should -ReturnZeroExitCode
        }
    }

    foreach ($version in $dotnetVersions) {
        Context "Dotnet $version" {
            $dotnet = @{ dotnetVersion = $version }

            It "SDK $version is available" -TestCases $dotnet {
                (dotnet --list-sdks | Where-Object { $_ -match "${dotnetVersion}\.[0-9]*" }).Count | Should -BeGreaterThan 0
            }

            It "Runtime $version is available" -TestCases $dotnet {
                (dotnet --list-runtimes | Where-Object { $_ -match "${dotnetVersion}\.[0-9]*" }).Count | Should -BeGreaterThan 0
            }
        }
    }
}