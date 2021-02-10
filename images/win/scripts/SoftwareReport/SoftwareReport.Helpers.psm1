function Build-MarkdownElement
{
    <#
    .SYNOPSIS
    Build markdown element for cached tool.

    .DESCRIPTION
    Build markdown element that contains name of tool, set of versions and additional notes.

    .PARAMETER Head
    Header of cached tool markdown element

    .PARAMETER Content
    Array of lines that contains required information about installed tool instances.
    #>

    param
    (
        [String] $Head,
        [Object[]] $Content
    )

    $markdown = New-MDHeader $Head -Level 4
    $markdown += New-MDParagraph -Lines $Content

    return $markdown
}

function Get-CachedToolInstances
{
    <#
    .SYNOPSIS
    Returns hastable of installed cached tools.

    .DESCRIPTION
    Return hastable that contains versions and architectures for selected cached tool.

    .PARAMETER Name
    Name of cached tool.

    .PARAMETER VersionCommand
    Optional parameter. Command to return version of system default tool.

    .EXAMPLE
    Get-CachedToolInstances -Name "Python" -VersionCommand "--version"

    #>

    param
    (
        [String] $Name,
        [String] $VersionCommand
    )

    $toolInstances = @()
    $toolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $Name

    # Get all installed versions from TOOLSDIRECTORY folder
    $versions = Get-ChildItem $toolPath | Sort-Object { [System.Version]$_.Name }
    foreach ($version in $versions)
    {
        $instanceInfo = @{}

        # Create instance hashtable
        [string]$instanceInfo.Path = Join-Path -Path $toolPath -ChildPath $version.Name
        [string]$instanceInfo.Version = $version.Name

        ### Temporary workaround. Currently Boost instances don't have architecture subfolders.
        if ($Name -eq "Boost")
        {
            [string]$instanceInfo.Architecture = "x64, x86"
            $toolInstances += $instanceInfo
            continue
        }

        # Get all architectures for current version
        [array]$instanceInfo.Architecture_Array = Get-ChildItem $version.FullName -Name -Directory | Where-Object { $_ -match "^x[0-9]{2}$" }
        [string]$instanceInfo.Architecture = $instanceInfo.Architecture_Array -Join ", "

        # Add (default) postfix to version name, in case if current version is in environment path
        if (-not ([string]::IsNullOrEmpty($VersionCommand)))
        {
            $defaultVersion = $(& ($Name.ToLower()) $VersionCommand 2>&1)
            $defaultToolVersion = $defaultVersion   | Select-String -Pattern "\d+\.\d+\.\d+" -AllMatches `
                                                    | ForEach-Object { $_.Matches.Value }

            if ([version]$version.Name -eq [version]$defaultToolVersion)
            {
                $instanceInfo.Version += " (Default)"
            }
        }

        $toolInstances += $instanceInfo
    }

    return $toolInstances
}

function New-MDNewLine {
    param (
        [int] $Count = 1
    )
    $newLineSymbol = [System.Environment]::NewLine
    return $newLineSymbol * $Count
}