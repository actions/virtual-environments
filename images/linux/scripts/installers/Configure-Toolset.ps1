################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure toolset
################################################################################

function Get-ToolsetToolFullPath
{
    param
    (
        [Parameter(Mandatory)] [string] $ToolName,
        [Parameter(Mandatory)] [string] $ToolVersion,
        [Parameter(Mandatory)] [string] $ToolArchitecture
    )

    $toolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $toolName
    $toolPathVersion = Join-Path -Path $toolPath -ChildPath $toolVersion
    $foundVersion = Get-Item $toolPathVersion | Sort-Object -Property {[version]$_.name} -Descending | Select-Object -First 1
    $installationDir = Join-Path -Path $foundVersion -ChildPath $toolArchitecture
    return $installationDir
}

function Add-EnvironmentVariable
{
    param
    (
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Value,
        [string] $FilePath = "/etc/environment"
    )

    $envVar = "{0}={1}" -f $name, $value
    Tee-Object -InputObject $envVar -FilePath $filePath -Append
}

$ErrorActionPreference = "Stop"

Write-Host "Configure toolset tools environment..."
$toolsEnvironment = @{
    boost = @{
        variableTemplate = "BOOST_ROOT_{0}_{1}_{2}"
    }
    go = @{
        command = "ln -s {0}/bin/* /usr/bin/"
        defaultVariable = "GOROOT"
        variableTemplate = "GOROOT_{0}_{1}_X64"
    }
}

$toolset = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw | ConvertFrom-Json

foreach ($tool in $toolset.toolcache)
{
    $toolName = $tool.name
    $toolArch = $tool.arch
    $toolEnvironment = $toolsEnvironment[$toolName]

    if (-not $toolEnvironment)
    {
        continue
    }

    foreach ($toolVersion in $tool.versions)
    {
        Write-Host "Set $toolName $toolVersion environment variable..."
        $toolPath = Get-ToolsetToolFullPath -ToolName $toolName -ToolVersion $toolVersion -ToolArchitecture $toolArch
        $envName = $toolEnvironment.variableTemplate -f $toolVersion.split(".")

        # Add environment variable name=value
        Add-EnvironmentVariable -Name $envName -Value $toolPath
    }

    # Invoke command and add env variable for the default tool version
    $toolDefVersion = $tool.default
    if (-not $toolDefVersion)
    {
        continue
    }

    $envDefName = $toolEnvironment.defaultVariable
    $toolPath = Get-ToolsetToolFullPath -ToolName $toolName -ToolVersion $toolDefVersion -ToolArchitecture $toolArch

    if ($envDefName)
    {
        Write-Host "Set default $envDefName for $toolName $toolDefVersion environment variable..."
        Add-EnvironmentVariable -Name $envDefName -Value $toolPath
    }

    if ($toolEnvironment.command)
    {
        $command = $toolEnvironment.command -f $toolPath
        Write-Host "Invoke $command command for default $toolName $toolDefVersion..."
        Invoke-Expression -Command $command
    }
}
