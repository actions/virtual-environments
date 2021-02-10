################################################################################
##  File:  Download-ToolCache.ps1
##  Team:  CI-Build
##  Desc:  Download tool cache
################################################################################

Function Install-NpmPackage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String] $PackageName,
        [Parameter(Mandatory=$true)]
        [System.Uri] $FeedPrefix
    )

    Push-Location -Path $env:TEMP

    $FeedUri = $FeedPrefix.AbsoluteUri

    Write-Host "Installing npm $PackageName from ${FeedUri}"
    npm install $PackageName --registry "${FeedUri}"

    if($LASTEXITCODE) {
        Write-Host "$PackageName installation failure;  Error: ${LASTEXITCODE}"

        exit 1
    }

    Pop-Location
}

Function NPMFeed-AuthSetup {
    param(
        [Parameter(Mandatory=$true)]
        [System.String] $AccessToken,
        [Parameter(Mandatory=$true)]
        [System.Uri] $FeedPrefix
    )

    $FeedHost = $FeedPrefix.Host

    Write-Host "Configure auth for github package registry"
    $npmrcContent = "//${FeedHost}/:_authToken=${AccessToken}"
    $npmrcContent | Out-File -FilePath "$($env:TEMP)/.npmrc" -Encoding utf8
}

Function Set-DefaultRubyVersion {
    param(
        [Parameter(Mandatory=$true)]
        [System.Version] $Version,
        [System.String] $Arch = "x64"
    )
    $rubyPath = $Env:AGENT_TOOLSDIRECTORY + "/Ruby/${Version}*/${Arch}/bin"
    $rubyDir = Get-Item -Path $rubyPath

    Write-Host "Use Ruby ${Version} as a system Ruby"
    Add-MachinePathItem -PathItem $rubyDir.FullName

    $env:Path = Get-MachinePath

    # Update ruby gem to latest version
    Invoke-Expression "gem update --system"
}

$FeedPrefix = "https://npm.pkg.github.com"
$AccessToken = $env:GITHUB_FEED_TOKEN

# HostedToolCache Path
$Dest = "C:/"
$Path = "hostedtoolcache/windows"
$ToolsDirectory = $Dest + $Path

# Define AGENT_TOOLSDIRECTORY environment variable
$env:AGENT_TOOLSDIRECTORY = $ToolsDirectory
setx AGENT_TOOLSDIRECTORY $ToolsDirectory /M

# Install HostedToolCache tools via NPM
$ToolVersionsFileContent = Get-Content -Path "$env:ROOT_FOLDER/toolcache.json" -Raw
$ToolVersions = ConvertFrom-Json -InputObject $ToolVersionsFileContent

NPMFeed-AuthSetup -AccessToken $AccessToken -FeedPrefix $FeedPrefix

$ToolVersions.PSObject.Properties | ForEach-Object {
    $PackageName = $_.Name
    $PackageVersions = $_.Value
    $NpmPackages = $PackageVersions | ForEach-Object { "$PackageName@$_" }
    foreach($NpmPackage in $NpmPackages) {
        Install-NpmPackage -PackageName $NpmPackage -FeedPrefix $FeedPrefix
    }
}

Set-DefaultRubyVersion -Version "2.5"