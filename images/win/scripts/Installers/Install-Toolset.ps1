################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Function Install-Asset {
    param(
        [Parameter(Mandatory=$true)]
        [object] $ReleaseAsset
    )

    $releaseAssetName = [System.IO.Path]::GetFileNameWithoutExtension($ReleaseAsset.filename)
    $assetFolderPath = Join-Path $env:TEMP $releaseAssetName
    $assetArchivePath = Start-DownloadWithRetry -Url $ReleaseAsset.download_url -Name $ReleaseAsset.filename

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    if ($assetArchivePath.EndsWith(".tar.gz")) {
        $assetTarPath = $assetArchivePath.TrimEnd(".tar.gz")
        Extract-7Zip -Path $assetArchivePath -DestinationPath $assetTarPath
        Extract-7Zip -Path $assetTarPath -DestinationPath $assetFolderPath
    } else {
        Extract-7Zip -Path $assetArchivePath -DestinationPath $assetFolderPath
    }

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression .\setup.ps1
    Pop-Location
}

# Get toolcache content from toolset
$ToolsToInstall = @("Python", "Node", "Boost", "Go")

$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
                         | Select-Object -ExpandProperty files `
                         | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) -and ($_.toolset -eq $tool.toolset) } `
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