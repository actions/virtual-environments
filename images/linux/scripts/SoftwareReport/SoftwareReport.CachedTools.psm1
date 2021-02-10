function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "PyPy"
    Get-ChildItem -Path $toolcachePath -Name | Sort-Object { [Version] $_ } | ForEach-Object {
        $pypyRootPath = Join-Path $toolcachePath $_ "x64"
        [string]$pypyVersionOutput = & "$pypyRootPath/bin/python" -c "import sys;print(sys.version)"
        $pypyVersionOutput -match "^([\d\.]+) \(.+\) \[PyPy ([\d\.]+) .+]$" | Out-Null
        return "{0} [PyPy {1}]" -f $Matches[1], $Matches[2]
    }
}

function Get-ToolcacheNodeVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "node"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheGoVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "go"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheBoostVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "boost"
    if (-not (Test-Path $toolcachePath)) {
        return @()
    }
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Build-CachedToolsSection {
    $output = ""

    $output += New-MDHeader "Ruby" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheRubyVersions) -Style Unordered

    $output += New-MDHeader "Python" -Level 4
    $output += New-MDList -Lines (Get-ToolcachePythonVersions) -Style Unordered

    $output += New-MDHeader "PyPy" -Level 4
    $output += New-MDList -Lines (Get-ToolcachePyPyVersions) -Style Unordered

    $output += New-MDHeader "Node.js" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheNodeVersions) -Style Unordered

    $output += New-MDHeader "Go" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheGoVersions) -Style Unordered

    $boostVersions = Get-ToolcacheBoostVersions
    if ($boostVersions.Count -gt 0) {
        $output += New-MDHeader "Boost" -Level 4
        $output += New-MDList -Lines $boostVersions -Style Unordered
    }

    return $output
}