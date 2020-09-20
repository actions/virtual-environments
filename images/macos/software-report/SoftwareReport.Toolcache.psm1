Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache/PyPy/*/x64"
    Get-ChildItem -Path $toolcachePath | Sort-Object { [Version] $_.Parent.Name } | ForEach-Object {
        $foundVersionPath = $_.FullName
        $foundVersionName = (Get-Item ($foundVersionPath -replace "x64") | Sort-Object -Property {[version]$_.name} -Descending | Select-Object -First 1).name
        $arrPyPyVersion = ((& "$foundVersionPath/bin/python" -c "import sys;print(sys.version.split('\n')[1])") -split " ")
        $pypyVersion = "$($arrPyPyVersion[0]) $($arrPyPyVersion[1])"
        return "{0} {1}]" -f $foundVersionName, $pypyVersion
    }
}

function Get-ToolcacheNodeVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Node"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheGoVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Go"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Build-ToolcacheSection { 
    $output = ""
    $output += New-MDHeader "Cached Tools" -Level 3
    $output += New-MDHeader "Ruby" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheRubyVersions) -Style Unordered
    $output += New-MDHeader "Python" -Level 4
    $output += New-MDList -Lines (Get-ToolcachePythonVersions) -Style Unordered
    
    if ($os.IsLessThanBigSur) {
        $output += New-MDHeader "PyPy" -Level 4
        $output += New-MDList -Lines (Get-ToolcachePyPyVersions) -Style Unordered
    }

    if( -not $os.IsHighSierra) {
        $output += New-MDHeader "Node.js" -Level 4
        $output += New-MDList -Lines (Get-ToolcacheNodeVersions) -Style Unordered
        $output += New-MDHeader "Go" -Level 4
        $output += New-MDList -Lines (Get-ToolcacheGoVersions) -Style Unordered
    }

    return $output
}

function Get-PowerShellModules {
    $modules = (Get-ToolsetValue powershellModules).name

    $psModules = Get-Module -Name $modules -ListAvailable | Sort-Object Name | Group-Object Name
    $psModules | ForEach-Object {
        $moduleName = $_.Name
        $moduleVersions = ($_.group.Version | Sort-Object -Unique) -join '<br>'

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
        }
    }
}