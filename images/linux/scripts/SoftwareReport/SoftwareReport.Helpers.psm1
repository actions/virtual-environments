function Get-CommandResult {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $Multiline
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $stdout = & bash -c "$Command 2>&1"
    $exitCode = $LASTEXITCODE
    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

function Take-OutputPart {
    param (
        [Parameter(ValueFromPipeline)]
        [string] $toolOutput,
        [string] $Delimiter = " ",
        [int[]] $Part
    )
    $parts = $toolOutput.Split($Delimiter, [System.StringSplitOptions]::RemoveEmptyEntries)
    $selectedParts = $parts[$Part]
    return [string]::Join($Delimiter, $selectedParts)
}

function Test-IsUbuntu16 {
    return (lsb_release -rs) -eq "16.04"
}

function Test-IsUbuntu18 {
    return (lsb_release -rs) -eq "18.04"
}

function Test-IsUbuntu20 {
    return (lsb_release -rs) -eq "20.04"
}

function Get-ToolsetContent {
    $toolset = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    Get-Content $toolset -Raw | ConvertFrom-Json
}

function New-MDNewLine {
    param (
        [int] $Count = 1
    )
    $newLineSymbol = [System.Environment]::NewLine
    return $newLineSymbol * $Count
}

function Restore-UserOwner {
    sudo chown -R ${env:USER}: $env:HOME
}