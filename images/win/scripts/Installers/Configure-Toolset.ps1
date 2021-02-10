################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure Toolset
################################################################################

Function Set-DefaultVariables
{
    param
    (
        [Parameter(Mandatory=$true)]
        [object] $EnvVars,
        [Parameter(Mandatory=$true)]
        [string] $ToolVersionPath
    )

    $templates = $EnvVars.pathTemplates
    foreach ($template in $templates)
    {
        $toolSystemPath = $template -f $ToolVersionPath
        Add-MachinePathItem -PathItem $toolSystemPath | Out-Null
    }

    if (-not ([string]::IsNullOrEmpty($EnvVars.defaultVariable)))
    {
        setx $toolEnvVars.defaultVariable $ToolVersionPath /M | Out-Null
    }
}

# Define executables for cached tools
$toolsEnvironmentVariables = @{
    Python = @{
        pathTemplates = @(
            "{0}",
            "{0}\Scripts"
        )
    }
    Boost = @{
        variableTemplate = "BOOST_ROOT_{0}_{1}_{2}"
    }
    go = @{
        pathTemplates = @(
            "{0}\bin"
        )
        defaultVariable = "GOROOT"
        variableTemplate = "GOROOT_{0}_{1}_X64"
    }
}

$toolsToConfigure = @("Python", "Boost", "Go")
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache `
                            | Where-Object { $toolsToConfigure -contains $_.name }

Write-Host "Configure toolset tools environment..."
foreach ($tool in $tools)
{
    $toolEnvVars = $toolsEnvironmentVariables[$tool.name]

    if (-not ([string]::IsNullOrEmpty($toolEnvVars.variableTemplate)))
    {
        foreach ($version in $tool.versions)
        {
            Write-Host "Set $($tool.name) $version environment variable..."

            $foundVersionArchPath = Get-ToolsetToolFullPath -Name $tool.name -Version $version -Arch $tool.arch
            $envName = $toolEnvVars.variableTemplate -f $version.Split(".")

            setx $envName $foundVersionArchPath /M | Out-Null
        }
    }

    if (-not ([string]::IsNullOrEmpty($tool.default)))
    {
        Write-Host "Use $($tool.name) $($tool.default) as a system $($tool.name)..."

        $toolVersionPath = Get-ToolsetToolFullPath -Name $tool.name -Version $tool.default -Arch $tool.arch

        Set-DefaultVariables -ToolVersionPath $toolVersionPath -EnvVars $toolEnvVars
    }
}

Invoke-PesterTests -TestFile "Toolset"