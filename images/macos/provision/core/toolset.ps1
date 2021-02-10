################################################################################
##  File:  toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Function Get-ToolcacheFromToolset {
    $toolsetPath = Join-Path $env:HOME "image-generation" "toolset.json"
    $toolsetJson = Get-Content -Raw $toolsetPath | ConvertFrom-Json
    return $toolsetJson.toolcache
}

Function Install-Asset {
    param(
        [Parameter(Mandatory=$true)]
        [object] $ReleaseAsset
    )

    $assetFolderPath = Join-Path "/tmp" "$($ReleaseAsset.filename)-temp-dir"
    New-Item -ItemType Directory -Path $assetFolderPath | Out-Null
    $assetArchivePath = Join-Path $assetFolderPath $ReleaseAsset.filename

    Write-Host "Download $($ReleaseAsset.filename) archive to the $assetFolderPath folder..."
    wget -P $assetFolderPath $ReleaseAsset.download_url --retry-connrefused --retry-on-http-error=429,500,503 --wait=30 --no-verbose

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    tar -xzf $assetArchivePath -C $assetFolderPath

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression "bash ./setup.sh"
    Pop-Location
}

# Get toolcache content from toolset
$toolsToInstall = @("Python", "Node", "Go")
$tools =  Get-ToolcacheFromToolset | Where-Object {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($version in $tool.versions) {
        $asset = $assets | Where-Object version -like $version `
                         | Select-Object -ExpandProperty files `
                         | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) -and ($_.platform_version -eq $tool.platform_version)} `
                         | Select-Object -First 1

        Write-Host "Installing $($tool.name) $version..."
        if ($null -ne $asset) {
            Install-Asset -ReleaseAsset $asset
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}