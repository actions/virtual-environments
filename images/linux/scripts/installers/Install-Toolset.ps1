################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Function Install-Asset {
    param(
        [Parameter(Mandatory = $true)]
        [object] $ReleaseAsset
    )

    Write-Host "Download $($ReleaseAsset.filename)"
    wget $ReleaseAsset.download_url -nv --retry-connrefused --tries=10

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    $assetFolderPath = Join-Path $env:INSTALLER_SCRIPT_FOLDER $($ReleaseAsset.filename)
    New-Item -ItemType Directory -Path $assetFolderPath
    tar -xzf $ReleaseAsset.filename -C $assetFolderPath

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression "bash ./setup.sh"
    Pop-Location
}

$ErrorActionPreference = "Stop"

# Get toolset content
$toolset = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$toolsToInstall = @("Python", "Node", "Boost", "Go")

$tools = ConvertFrom-Json -InputObject $toolset | Select-Object -ExpandProperty toolcache | Where-Object {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
        | Select-Object -ExpandProperty files `
        | Where-Object { ($_.platform -eq $tool.platform) -and ($_.platform_version -eq $tool.platform_version)} `
        | Select-Object -First 1

        Write-Host "Installing $($tool.name) $toolVersion $($tool.arch)..."
        if ($null -ne $asset) {
            Install-Asset -ReleaseAsset $asset
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}

chown -R "$($env:SUDO_USER):$($env:SUDO_USER)" /opt/hostedtoolcache/Python
chown -R "$($env:SUDO_USER):$($env:SUDO_USER)" /opt/hostedtoolcache/node
chown -R "$($env:SUDO_USER):$($env:SUDO_USER)" /opt/hostedtoolcache/go