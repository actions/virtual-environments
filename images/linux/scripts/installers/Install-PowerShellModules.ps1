$ErrorActionPreference = "Stop"

function Get-ToolsetContent
{
    $toolset = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    Get-Content $toolset -Raw | ConvertFrom-Json
}

# Specifies the installation policy
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

# Install PowerShell modules
$modules = (Get-ToolsetContent).powershellModules

foreach($module in $modules)
{
    $moduleName = $module.name
    Write-Host "Installing ${moduleName} module"

    if ($module.versions)
    {
        foreach ($version in $module.versions)
        {
            Write-Host " - $version"
            Install-Module -Name $moduleName -RequiredVersion $version -Scope AllUsers -SkipPublisherCheck -Force
        }
        continue
    }

    Install-Module -Name $moduleName -Scope AllUsers -SkipPublisherCheck -Force
}
