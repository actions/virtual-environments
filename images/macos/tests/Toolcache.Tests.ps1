Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

$os = Get-OSVersion

Describe "Toolcache" {
    $toolcacheDirectory = Join-Path $env:HOME "hostedtoolcache"
    $packages = (Get-ToolcachePackages).PSObject.Properties | ForEach-Object {
        $packageNameParts = $_.Name.Split("-")
        return [PSCustomObject] @{
            ToolName = $packageNameParts[1]
            Arch = $packageNameParts[4]
            Versions = $_.Value
        }
    }
    
    [array]$packages += Get-ToolsetValue -KeyPath "toolcache" | ForEach-Object {
        return [PSCustomObject] @{
            ToolName = ($_.name).ToLower()
            Arch = $_.arch
            Versions = $_.versions | ForEach-Object { $_.Replace(".*", "") }
        }
    }

    Context "Python" {
        $pythonDirectory = Join-Path $toolcacheDirectory "Python"
        $pythonPackage = $packages | Where-Object { $_.ToolName -eq "python" } | Select-Object -First 1
        $testCase = @{ PythonDirectory = $pythonDirectory }

        It "Toolcache directory exists" -TestCases $testCase {
            param ( [string] $PythonDirectory )

            $PythonDirectory | Should -Exist
        }

        It "Toolcache directory contains at least one version of Python" -TestCases $testCase {
            param ( [string] $PythonDirectory )

            (Get-ChildItem -Path $PythonDirectory -Directory).Count | Should -BeGreaterThan 0
        }

        $pythonPackage.Versions | Where-Object { $_ } | ForEach-Object {
            Context "$_" {
                $versionDirectory = Get-ChildItem -Path $pythonDirectory -Directory -Filter "$_*" | Select-Object -First 1
                $pythonBinPath = Join-Path $versionDirectory.FullName $pythonPackage.Arch "python"
                $testCase = @{ PythonVersion = $_; PythonBinPath = $pythonBinPath }

                It "Version" -TestCases $testCase {
                    param (
                        [string] $PythonVersion,
                        [string] $PythonBinPath
                    )

                    $result = Get-CommandResult "$PythonBinPath --version"
                    $result.Output | Should -BeLike "*$PythonVersion*"
                    $result.ExitCode | Should -Be 0
                }

                It "Run test script" -TestCases $testCase {
                    param ( [string] $PythonBinPath )

                    "$PythonBinPath -c 'import sys;print(sys.version)'" | Should -ReturnZeroExitCode
                }
            }
        }
    }

    Context "Ruby" {
        $rubyDirectory = Join-Path $toolcacheDirectory "Ruby"
        $rubyPackage = $packages | Where-Object { $_.ToolName -eq "ruby" } | Select-Object -First 1
        $testCase = @{ RubyDirectory = $rubyDirectory }
        
        It "Toolcache directory exists" -TestCases $testCase {
            param ( [string] $RubyDirectory )

            $RubyDirectory | Should -Exist
        }

        It "Toolcache directory contains at least one version of Ruby" -TestCases $testCase {
            param ( [string] $RubyDirectory )

            (Get-ChildItem -Path $RubyDirectory -Directory).Count | Should -BeGreaterThan 0
        }

        $rubyPackage.Versions | Where-Object { $_ } | ForEach-Object {
            Context "$_" {
                $versionDirectory = Get-ChildItem -Path $rubyDirectory -Directory -Filter "$_*" | Select-Object -First 1
                $rubyBinPath = Join-Path $versionDirectory.FullName $rubyPackage.Arch "bin" "ruby"
                $testCase = @{ RubyVersion = $_; RubyBinPath = $rubyBinPath }

                It "Version" -TestCases $testCase {
                    param (
                        [string] $RubyVersion,
                        [string] $RubyBinPath
                    )

                    $result = Get-CommandResult "$RubyBinPath --version"
                    $result.Output | Should -BeLike "*$RubyVersion*"
                    $result.ExitCode | Should -Be 0
                }

                It "Run test script" -TestCases $testCase {
                    param ( [string] $RubyBinPath )

                    "$RubyBinPath -e 'puts RUBY_VERSION'" | Should -ReturnZeroExitCode
                }
            }
        }
    }
    Context "PyPy" -Skip:($os.IsBigSur) {
        $pypyDirectory = Join-Path $toolcacheDirectory "PyPy"
        $pypyPackage = $packages | Where-Object { $_.ToolName -eq "pypy" } | Select-Object -First 1
        $testCase = @{ PypyDirectory = $pypyDirectory }

        It "Toolcache directory exists" -TestCases $testCase {
            param ( [string] $PypyDirectory )

            $PypyDirectory | Should -Exist
        }

        It "Toolcache directory contains at least one version of PyPy" -TestCases $testCase {
            param ( [string] $PypyDirectory )
                
            (Get-ChildItem -Path $PypyDirectory -Directory).Count | Should -BeGreaterThan 0
        }

    $pypyPackage.Versions | Where-Object { $_ } | ForEach-Object {
        Context "$_" {
            $versionDirectory = Get-ChildItem -Path $pypyDirectory -Directory -Filter "$_*" | Select-Object -First 1
            $binFilename = If ($_.StartsWith("3")) { "pypy3" } else { "pypy" }
            $pypyBinPath = Join-Path $versionDirectory.FullName $pypyPackage.Arch "bin" $binFilename
            $testCase = @{ PypyVersion = $_; PypyBinPath = $pypyBinPath }

                It "Version" -TestCases $testCase {
                    param (
                        [string] $PypyVersion,
                        [string] $PypyBinPath
                    )

                    $result = Get-CommandResult "$PypyBinPath --version"
                    $result.Output | Should -BeLike "*$PypyVersion*"
                    $result.ExitCode | Should -Be 0
                }

                It "Run test script" -TestCases $testCase {
                    param ( [string] $PypyBinPath )

                    "$PypyBinPath -c 'import sys;print(sys.version)'" | Should -ReturnZeroExitCode
                }
            }
        }
    }

    Context "Node" -Skip:($os.IsHighSierra) {
        $nodeDirectory = Join-Path $toolcacheDirectory "node"
        $nodePackage = $packages | Where-Object { $_.ToolName -eq "node" } | Select-Object -First 1
        $testCase = @{ NodeDirectory = $nodeDirectory }
        
        It "Toolcache directory exists" -TestCases $testCase {
            param ( [string] $NodeDirectory )
            
            $NodeDirectory | Should -Exist
        }

        It "Toolcache directory contains at least one version of Node" -TestCases $testCase {
            param ( [string] $NodeDirectory )

            (Get-ChildItem -Path $NodeDirectory -Directory).Count | Should -BeGreaterThan 0
        }

        $nodePackage.Versions | Where-Object { $_ } | ForEach-Object {
            Context "$_" {
                $versionDirectory = Get-ChildItem -Path $nodeDirectory -Directory -Filter "$_*" | Select-Object -First 1
                $nodeBinPath = Join-Path $versionDirectory.FullName $nodePackage.Arch "bin" "node"
                $npmBinPath = Join-Path $versionDirectory.FullName $nodePackage.Arch "bin" "npm"
                $testCase = @{ NodeVersion = $_; NodeBinPath = $nodeBinPath; NpmBinPath = $npmBinPath }

                It "Version Node" -TestCases $testCase {
                    param ( 
                        [string] $NodeVersion,
                        [string] $NodeBinPath
                    )

                    $result = Get-CommandResult "$NodeBinPath --version"
                    $result.Output | Should -BeLike "*$NodeVersion*"
                    $result.ExitCode | Should -Be 0
                }

                It "Version Npm" -TestCases $testCase {
                    param ( [string] $NpmBinPath )

                    "$NpmBinPath --version" | Should -ReturnZeroExitCode
                }

                It "Run test script" -TestCases $testCase {
                    param ( [string] $NodeBinPath )

                    "$NodeBinPath -e 'console.log(process.version)'" | Should -ReturnZeroExitCode
                }
            }
        }
    }

    Context "Go" -Skip:($os.IsHighSierra) {
        $goDirectory = Join-Path $toolcacheDirectory "go"
        $goPackage = $packages | Where-Object { $_.ToolName -eq "go" } | Select-Object -First 1
        $testCase = @{ GoDirectory = $goDirectory }
        
        It "Toolcache directory exists" -TestCases $testCase {
            param ( [string] $GoDirectory )

            $GoDirectory | Should -Exist
        }

        It "Toolcache directory contains at least one version of Go" -TestCases $testCase {
            param ( [string] $GoDirectory )

            (Get-ChildItem -Path $GoDirectory -Directory).Count | Should -BeGreaterThan 0
        }

        $goPackage.Versions | Where-Object { $_ } | ForEach-Object {
            Context "$_" {
                $versionDirectory = Get-ChildItem -Path $goDirectory -Directory -Filter "$_*" | Select-Object -First 1
                $goBinPath = Join-Path $versionDirectory.FullName $goPackage.Arch "bin" "go"
                $testCase = @{ GoVersion = $_; GoBinPath = $goBinPath }
                
                It "Version Go" -TestCases $testCase {
                    param (
                        [string] $GoVersion,
                        [string] $GoBinPath
                    )

                    $result = Get-CommandResult "$GoBinPath version"
                    $result.Output | Should -BeLike "*$GoVersion*"
                    $result.ExitCode | Should -Be 0
                }
            }
        }
    }
}