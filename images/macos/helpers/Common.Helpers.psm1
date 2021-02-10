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

# Gets path to the tool, analogue of 'which tool'
function Get-WhichTool($tool) {
    return (Get-Command $tool).Path
}

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}

# Returns the object with information about current OS
# It can be used for OS-specific tests 
function Get-OSVersion {
    $osVersion = [Environment]::OSVersion
    return [PSCustomObject]@{
        Version = $osVersion.Version
        Platform = $osVersion.Platform
        IsHighSierra = $osVersion.Version.Major -eq 17
        IsMojave = $osVersion.Version.Major -eq 18
        IsCatalina = $osVersion.Version.Major -eq 19
        IsBigSur = $osVersion.Version.Major -eq 20
        IsLessThanCatalina = $osVersion.Version.Major -lt 19
        IsLessThanBigSur = $osVersion.Version.Major -lt 20
        IsHigherThanMojave = $osVersion.Version.Major -gt 18 
    }
}

function Get-ChildItemWithoutSymlinks {
    param (
        [Parameter(Mandatory)]
        [string] $Path,
        [string] $Filter
    )

    $files = Get-ChildItem -Path $Path -Filter $Filter
    $files = $files | Where-Object { !$_.LinkType } # cut symlinks
    return $files
}

# Get the value of specific toolset node
# Example, invoke `Get-ToolsetValue "xamarin.bundles"` to get value of `$toolsetJson.xamarin.bundles`
function Get-ToolsetValue {
    param (
        [Parameter(Mandatory = $true)]
        [string] $KeyPath
    )
    $toolsetPath = Join-Path $env:HOME "image-generation" "toolset.json"
    $jsonNode = Get-Content -Raw $toolsetPath | ConvertFrom-Json

    $pathParts = $KeyPath.Split(".")
    # try to walk through all arguments consequentially to resolve specific json node 
    $pathParts | ForEach-Object {
        $jsonNode = $jsonNode.$_
    }
    return $jsonNode
}

function Get-ToolcachePackages {
    $toolcachePath = Join-Path $env:HOME "image-generation" "toolcache.json"
    return Get-Content -Raw $toolcachePath | ConvertFrom-Json
}