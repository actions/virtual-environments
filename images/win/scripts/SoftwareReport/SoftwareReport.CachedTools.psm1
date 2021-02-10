function Get-BoostMarkdown
{
    $Name = "Boost"
    $ToolInstances = Get-CachedToolInstances -Name $Name
    foreach ($Instance in $ToolInstances)
    {
        $VersionEnvVar = $Instance.Version.replace(".", "_")
        $Instance."Environment Variable" = "BOOST_ROOT_${VersionEnvVar}"
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        Version = "left";
        Architecture = "left";
        "Environment Variable" = "left"
    })
    $Content += New-MDHeader "Notes:" -Level 5
    $Content += @'
```
1. Environment variable "BOOST_ROOT" is not set by default.
   Please make sure you set this variable value to proper value
   from table above depending on the Boost version you are using.
2. If Boost was built using the boost-cmake project or from Boost 1.70.0
   on it provides a package configuration file for use with find_package's config mode.
   This module looks for the package configuration file called BoostConfig.cmake or boost-config.cmake
   and stores the result in CACHE entry "Boost_DIR". If found, the package configuration file
   is loaded and this module returns with no further action.
   See documentation of the Boost CMake package configuration for details on what it provides.
   Set Boost_NO_BOOST_CMAKE to ON, to disable the search for boost-cmake.
   Link: https://cmake.org/cmake/help/latest/module/FindBoost.html
```
'@

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-GoMarkdown
{
    $Name = "Go"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "version"
    foreach ($Instance in $ToolInstances)
    {
        $Version = [System.Version]($Instance.Version -Split(" "))[0]
        $Instance."Environment Variable" = "GOROOT_$($Version.major)_$($Version.minor)_X64"
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        Version = "left";
        Architecture = "left";
        "Environment Variable" = "left"
    })

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-NodeMarkdown
{
    $Name = "Node"
    $ToolInstances = Get-CachedToolInstances -Name $Name
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PythonMarkdown
{
    $Name = "Python"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-RubyMarkdown
{
    $Name = "Ruby"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PyPyMarkdown
{
    $Name = "PyPy"
    $ToolInstances = Get-CachedToolInstances -Name $Name
    foreach ($Instance in $ToolInstances)
    {
        $Instance."PyPy Version" = @()
        $Instance."Python Version" = $Instance.Version
        foreach ($Arch in $Instance.Architecture_Array)
        {
            $pythonExePath = Join-Path $Instance.Path $Arch | Join-Path -ChildPath "python.exe"
            $Instance."PyPy Version" += (& $pythonExePath -c "import sys;print(sys.version.split('\n')[1])").Trim("[]")
        }
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        "Python Version" = "left";
        Architecture = "left";
        "PyPy Version" = "left"
    })

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Build-CachedToolsMarkdown
{
    $markdown = ""
    $markdown += Get-BoostMarkdown
    $markdown += Get-GoMarkdown
    $markdown += Get-NodeMarkdown
    $markdown += Get-PythonMarkdown
    $markdown += Get-RubyMarkdown
    $markdown += Get-PyPyMarkdown

    return $markdown
}