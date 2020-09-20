Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$os = Get-OSVersion

Describe "Disk free space" {
    It "Image has more than 10GB free space" {
        # we should have at least 10 GB of free space on macOS images
        # https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#capabilities-and-limitations
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 10GB
    }
}

Describe "Git" {
    It "git is installed" {
        "git --version" | Should -ReturnZeroExitCode
    }

    It "git lfs is installed" {
        "git lfs version" | Should -ReturnZeroExitCode
    }

    It "hub CLI is installed" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}

Describe "Audio device" -Skip:($os.IsHighSierra -or $os.IsBigSur) {
    It "Sox is installed" {
        "sox --version" | Should -ReturnZeroExitCode
    }

    It "SwitchAudioSource is installed" {
        "SwitchAudioSource -c" | Should -ReturnZeroExitCode
    }

    It "Audio channel Soundflower (2ch)" {
        SwitchAudioSource -c | Should -BeLikeExactly "Soundflower (2ch)"
    }
}

Describe "Common utilities" {
    It "Homebrew" {
        "brew --version" | Should -ReturnZeroExitCode
    }

    It "DotNet" {
        "dotnet --version" | Should -ReturnZeroExitCode
    }

    It "Go" {
        "go version" | Should -ReturnZeroExitCode
    }

    It "Bundler" {
        "bundler --version" | Should -ReturnZeroExitCode
    }

    It "Maven" {
        "mvn --version" | Should -ReturnZeroExitCode
    }

    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }

    It "Carthage" {
        "carthage version" | Should -ReturnZeroExitCode
    }

    It "App Center CLI" {
        "appcenter --version" | Should -ReturnZeroExitCode
    }

    It "Azure CLI" {
        "az -v" | Should -ReturnZeroExitCode
    }

    Describe "AWS" {
        It "AWS CLI" {
            "aws --version" | Should -ReturnZeroExitCode
        }
        It "AWS SAM CLI" {
            "sam --version" | Should -ReturnZeroExitCode
        }

        It "AWS Session Manager CLI" {
            "session-manager-plugin --version" | Should -ReturnZeroExitCode
        }
    }

    It "Aliyun CLI" {
        "aliyun --version" | Should -ReturnZeroExitCode
    }

    It "Mobile Center CLI" {
        "mobile-center --version" | Should -ReturnZeroExitCode
    }

    It "Nomad CLI" {
        $result = Get-CommandResult "gem list"
        $result.Output | Should -BeLike "*nomad-cli*"
    }

    It "Nomad CLI IPA" {
        "ipa --version" | Should -ReturnZeroExitCode
    }

    It "Conda" {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }

    It "Fastlane" {
        "fastlane --version" | Should -ReturnZeroExitCode
    }

    It "Subversion" {
        "svn --version" | Should -ReturnZeroExitCode
    }

    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }

    It "curl" {
        "curl --version" | Should -ReturnZeroExitCode
    }

    It "xctool" {
        "xctool --version" | Should -ReturnZeroExitCode
    }

    It "xcpretty" {
        "xcpretty --version" | Should -ReturnZeroExitCode
    }

    It "wget" {
        "wget --version" | Should -ReturnZeroExitCode
    }

    It "mongodb" {
        "mongo --version" | Should -ReturnZeroExitCode
        "mongod --version"| Should -ReturnZeroExitCode
    }

    It "jq" {
        "jq --version" | Should -ReturnZeroExitCode
    }

    It "OpenSSL" {
        "openssl version" | Should -ReturnZeroExitCode
    }

    It "GnuPG" {
        "gpg --version" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL-Client" {
        "psql --version" | Should -ReturnZeroExitCode
    }
    
    It "PostgreSQL-Server" {
        "pg_config --version" | Should -ReturnZeroExitCode
    }

    It "Aria2" {
        "aria2c --version" | Should -ReturnZeroExitCode
    }

    It "Azcopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }

    It "PHP" {
        Get-WhichTool "php" | Should -Not -BeLike "/usr/bin/php*"
        "php --version" | Should -ReturnZeroExitCode
    }
    
    It "Composer" {
        "composer --version" | Should -ReturnZeroExitCode
    }
    
    It "R" -Skip:($os.IsBigSur) {
        "R --version" | Should -ReturnZeroExitCode
    }

    It "zstd" {
        "zstd --version" | Should -ReturnZeroExitCode
    }

    It "bazel" {
        "bazel --version" | Should -ReturnZeroExitCode
    }

    It "bazelisk" {
        "bazelisk version" | Should -ReturnZeroExitCode
    }
    
    It "Julia" {
        "julia --version" | Should -ReturnZeroExitCode
    }

    It "Packer" {
        "packer --version" | Should -ReturnZeroExitCode
    }

    It "Helm" {
        "helm version --short" | Should -ReturnZeroExitCode
    }

    It "virtualbox" {
        "vboxmanage -v" | Should -ReturnZeroExitCode
    }

    It "vagrant" {
        "vagrant --version" | Should -ReturnZeroExitCode
    }

    It "GitHub CLI" {
        "gh --version" | Should -ReturnZeroExitCode
    }

    It "7-Zip" {
        "7z i" | Should -ReturnZeroExitCode
    }

    It "Apache Ant" {
        "ant -version" | Should -ReturnZeroExitCode
    }
}

Describe "Browsers" {
    It "Chrome" {
        $chromeLocation = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        $chromeLocation | Should -Exist
        "'$chromeLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Chrome Driver" {
        "chromedriver --version" | Should -ReturnZeroExitCode
    }

    It "Microsoft Edge" {
        $edgeLocation = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
        $edgeLocation | Should -Exist
        "'$edgeLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Microsoft Edge Driver" {
        "msedgedriver --version" | Should -ReturnZeroExitCode
    }
    
    It "Firefox" {
        $firefoxLocation = "/Applications/Firefox.app/Contents/MacOS/firefox"
        $firefoxLocation | Should -Exist
        "'$firefoxLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Geckodriver" {
        "geckodriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Rust" -Skip:($os.IsHighSierra) {
    It "Rustup is installed" {
        "rustup --version" | Should -ReturnZeroExitCode
    }

    It "Rustc is installed" {
        "rustc --version" | Should -ReturnZeroExitCode
    }

    It "Cargo is installed" {
        "cargo --version" | Should -ReturnZeroExitCode
    }

    Context "Cargo dependencies" {
        It "bindgen" {
            "bindgen --version" | Should -ReturnZeroExitCode
        }

        It "cbindgen" {
            "cbindgen --version" | Should -ReturnZeroExitCode
        }

        It "Cargo audit" {
            "cargo audit --version" | Should -ReturnZeroExitCode
        }

        It "Cargo outdated" {
            "cargo outdated --version" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Haskell" -Skip:($os.IsHighSierra) {
    It "GHCup" {
        "ghcup --version" | Should -ReturnZeroExitCode
    }

    It "GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }
    
    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "Clang/LLVM" -Skip:($os.IsHighSierra) {
    It "Clang/LLVM is installed" {
        "$(brew --prefix llvm)/bin/clang --version" | Should -ReturnZeroExitCode
    }
}

Describe "Gcc" -Skip:($os.IsHighSierra) {
    $testCases = @("8", "9") | ForEach-Object { @{GccVersion = $_} }

    It "Gcc <GccVersion>" -TestCases $testCases {
        param (
            [string] $GccVersion
        )
        
        "gcc-$GccVersion --version" | Should -ReturnZeroExitCode
    }
}

Describe "Gfortran" -Skip:($os.IsHighSierra) {
    $testCases = @("8", "9") | ForEach-Object { @{GfortranVersion = $_} }

    It "Gfortran <GfortranVersion>" -TestCases $testCases {
        param (
            [string] $GfortranVersion
        )

        "gfortran-$GfortranVersion --version" | Should -ReturnZeroExitCode
    }
}

Describe "Screen Resolution" -Skip:($os.IsHighSierra) {
    It "Screen Resolution" {
        system_profiler SPDisplaysDataType | Select-String "Resolution" | Should -Match "1176 x 885"
    }
}

Describe "vcpkg" -Skip:($os.IsHighSierra -or $os.IsMojave) {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}

Describe "Newman" -Skip:($os.IsHighSierra -or $os.IsMojave) {
    It "Newman" {
        "newman --version" | Should -ReturnZeroExitCode
    }
}

Describe "Visual Studio For Mac" {
    It "VS4Mac is installed" {
        $vsPath = "/Applications/Visual Studio.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }
}