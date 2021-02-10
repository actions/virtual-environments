param (
    [Parameter(Mandatory=$true)]
    $WorkingDirectory,
    [Parameter(Mandatory=$true)]
    $OutputFile
)

$ErrorActionPreference = "Stop"

Import-Module Pester
Set-Location -Path $WorkingDirectory

$parentDirectory = Split-Path $OutputFile -Parent
if (-not (Test-Path $parentDirectory)) { New-Item -Path $parentDirectory -ItemType Directory | Out-Null }

$configuration = [PesterConfiguration] @{
    Output = @{ Verbosity = "Detailed" }
    TestResult = @{
        Enabled = $true
        OutputPath = $OutputFile;
        OutputFormat = "NUnitXML"
    }
}

Invoke-Pester -Configuration $configuration