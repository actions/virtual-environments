$toolsExecutables = @{
    Python = @(
        @{ Binary = "python.exe"; Arguments = "--version" },
        @{ Binary = "Scripts\pip.exe"; Arguments = "--version" }
    )
    PyPy = @(
        @{ Binary = "python.exe"; Arguments = "--version" },
        @{ Binary = "Scripts\pip.exe"; Arguments = "--version" }
    )
    Node = @(
        @{ Binary = "node.exe"; Arguments = "--version" },
        @{ Binary = "npm"; Arguments = "--version" }
    )
    Go = @(
        @{ Binary =  "bin\go.exe"; Arguments = "version" }
    )
    Ruby = @(
        @{ Binary = "bin\ruby.exe"; Arguments = "--version" }
    )
}

function Get-ToolExecutables {
    Param ([String] $Name)
    if ($toolsExecutables.ContainsKey($Name)) { $toolsExecutables[$Name] } else { @() }
}

function Test-Binaries {
    Param (
        [String] $Name,
        [String] $Version,
        [String] $Arch,
        [Array] $ToolExecs
    )
    $testCases = $ToolExecs | ForEach-Object {
        @{ Name = $Name; Version = $Version; Arch = $Arch; Binary = $_.Binary; Arguments = $_.Arguments }
    }
    It "<Binary> <Arguments>" -TestCases $testCases {
        $binaryFullPath = Join-Path (Get-ToolsetToolFullPath -Name $Name -Version $Version -Arch $Arch) $Binary
        "$binaryFullPath $Arguments" | Should -ReturnZeroExitCode
    }
}

function Test-DefaultVersion {
    Param (
        [String] $Name,
        [String] $ExpectedVersion,
        [Array] $ToolExecs
    )
    $binaryName = [IO.Path]::GetFileNameWithoutExtension($ToolExecs[0].Binary)
    $testCase = @{ Binary = $binaryName; Arguments = $ToolExecs[0].Arguments; ExpectedVersion = $ExpectedVersion }
    It "<ExpectedVersion> is default version" -TestCases $testCase {
        $commandResult = Get-CommandResult "$Binary $Arguments"
        $commandResult.ExitCode | Should -Be 0
        $commandResult.Output | Should -Match $ExpectedVersion
    }

    It "default version is located in tool-cache" -TestCases $testCase {
        $binaryFullPath = Get-WhichTool $Binary
        $toolcacheDirectory = Get-ToolcacheToolDirectory -ToolName $Name
        $binaryFullPath | Should -Match ([Regex]::Escape($toolcacheDirectory))
    }
}

$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache
# convert old tool-cache to toolset format on-flight to re-use code
(Get-ToolcachePackages).PSObject.Properties | ForEach-Object {
    $packageNameParts = $_.Name.Split("-")
    $tools += @{ name = $packageNameParts[1]; arch = $packageNameParts[3]; versions = $_.Value; default = "." }
}

foreach ($tool in $tools) {
    Describe "$($tool.name) [$($tool.arch)]" {
        $toolExecs = Get-ToolExecutables -Name $tool.name

        foreach ($version in $tool.versions) {
            Context "$version" {
                $toolInfo = @{ Name = $tool.name; Version = $version; Arch = $tool.arch }
                It "tool-cache directory exists" -TestCases $toolInfo {
                    $toolFullPath = Get-ToolsetToolFullPath -Name $Name -Version $Version -Arch $Arch
                    $toolFullPath | Should -Exist
                }

                if ($toolExecs) {
                    Test-Binaries -Name $tool.name -Version $version -Arch $tool.arch -ToolExecs $toolExecs
                }
            }
        }

        if ($tool.default -and $toolExecs) {
            Context "Default" {
                Test-DefaultVersion -Name $tool.name -ExpectedVersion $tool.default -ToolExecs $toolExecs
            }
        }
    }
}