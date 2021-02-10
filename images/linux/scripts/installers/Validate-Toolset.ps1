################################################################################
##  File:  Validate-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Validate Toolset
################################################################################

function Run-ExecutableTests {
    param (
        [Parameter(Mandatory)] [string[]] $Executables,
        [Parameter(Mandatory)] [string] $ToolPath
    )
    $versionCommand = $Executables["command"]

    foreach ($executable in $Executables["tools"]) {
        $executablePath = Join-Path $ToolPath $executable
        Write-Host "Check $executable..."
        if (Test-Path $executablePath) {
            Write-Host "$executable is successfully installed: $(& $executablePath $versionCommand)"
        } else {
            Write-Host "$executablePath is not installed!"
            exit 1
        }
    }
}

$ErrorActionPreference = "Stop"

# Define executables for cached tools
$toolsExecutables = @{
    Python = @{
        tools = @("python", "bin/pip")
        command = "--version"
    }
    node = @{
        tools = @("bin/node", "bin/npm")
        command = "--version"
    }
    PyPy = @{
        tools = @("bin/python", "bin/pip")
        command = "--version"
    }
    go = @{
        tools = @("bin/go")
        command = "version"
    }
}

# Get toolset content
$toolset = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$tools = ConvertFrom-Json -InputObject $toolset | Select-Object -ExpandProperty toolcache

foreach($tool in $tools) {

    $toolPath = Join-Path $env:AGENT_TOOLSDIRECTORY $tool.name
    # Get executables for current tool
    $toolExecs = $toolsExecutables[$tool.name]

    foreach ($version in $tool.versions) {
        # Add wildcard if missing
        if ($version.Split(".").Length -lt 3) {
            $version += ".*"
        }

        # Check if version folder exists
        $expectedVersionPath = Join-Path $toolPath $version
        if (-not (Test-Path $expectedVersionPath)) {
            Write-Host "Expected $($tool.name) $version folder is not found!"
            exit 1
        }

        # Take latest installed version in case if toolset version contains wildcards
        $foundVersion = Get-Item $expectedVersionPath `
                        | Sort-Object -Property {[version]$_.name} -Descending `
                        | Select-Object -First 1
        $foundVersionPath = Join-Path $foundVersion $tool.arch

        if ($toolExecs) {
            Write-Host "Run validation test for $($tool.name)($($tool.arch)) $($foundVersion.name) executables..."
            Run-ExecutableTests -Executables $toolExecs -ToolPath $foundVersionPath
        }
        $foundVersionName = $foundVersion.name
        if ($tool.name -eq 'PyPy')
        {
            $pypyVersion = & "$foundVersionPath/bin/python" -c "import sys;print(sys.version.split('\n')[1])"
            $foundVersionName = "{0} {1}" -f $foundVersionName, $pypyVersion
        }
    }
}