function Get-AzCosmosDBEmulatorVersion {
    $regKey = gci HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | gp | ? { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }
    $installDir = $regKey.InstallLocation
    $exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
    $version = (Get-Item $exeFilePath).VersionInfo.FileVersion
    return "Azure CosmosDb Emulator $version"
}

function Get-BazelVersion {
    ((cmd /c "bazel --version 2>&1") | Out-String) -match "bazel (?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazelVersion = $Matches.Version
    return "Bazel $bazelVersion"
}

function Get-BazeliskVersion {
    ((cmd /c "bazelisk version 2>&1") | Out-String) -match "Bazelisk version: v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazeliskVersion = $Matches.Version
    return "Bazelisk $bazeliskVersion"
}

function Get-RVersion {
    ($(cmd /c "Rscript --version 2>&1")  | Out-String) -match  "R scripting front-end version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $rVersion = $Matches.Version
    return "R $rVersion"
}

function Get-CMakeVersion {
    ($(cmake -version) | Out-String) -match  "cmake version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $cmakeVersion = $Matches.Version
    return "CMake $cmakeVersion"
}

function Get-CodeQLBundleVersion {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "codeql" | Join-Path -ChildPath "*"
    $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
    $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql.exe"
    $CodeQLVersion = & $CodeQLPath version --quiet
    return "CodeQL Action Bundle $CodeQLVersion"
}

function Get-DockerVersion {
    $dockerVersion = $(docker version --format "{{.Server.Version}}")
    return "Docker $dockerVersion"
}

function Get-DockerComposeVersion {
    $(docker-compose --version) -match "docker-compose version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $dockerComposeVersion = $Matches.Version
    return "Docker-compose $dockerComposeVersion"
}

function Get-GitVersion {
    $(git version) -match "git version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $gitVersion = $Matches.Version
    return "Git $gitVersion"
}

function Get-GitLFSVersion {
    $(git-lfs version) -match "git-lfs\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $gitLfsVersion = $Matches.Version
    return "Git LFS $gitLfsVersion"
}

function Get-InnoSetupVersion {
    return $(choco list --local-only innosetup) | Select-String -Pattern "InnoSetup"
}

function Get-JQVersion {
    $jqVersion = ($(jq --version) -Split "jq-")[1]
    return "jq $jqVersion"
}

function Get-KubectlVersion {
    $(kubectl version --client=true --short=true) -match "Client Version: v(?<version>.+)" | Out-Null
    $kubectlVersion = $Matches.Version
    return "Kubectl $kubectlVersion"
}

function Get-KindVersion {
    $(kind version) -match "kind v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $kindVersion = $Matches.Version
    return "Kind $kindVersion"
}

function Get-MinGWVersion {
    (gcc --version | Select-String -Pattern "MinGW-W64 project") -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $mingwVersion = $Matches.Version
    return "Mingw-w64 $mingwVersion"
}

function Get-MySQLVersion {
    $mysqlCommand = Get-Command -Name "mysql"
    $mysqlVersion = $mysqlCommand.Version.ToString()
    return "MySQL $mysqlVersion"
}

function Get-MercurialVersion {
    ($(hg --version) | Out-String) -match "version (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $mercurialVersion = $Matches.Version
    return "Mercurial $mercurialVersion"
}

function Get-NSISVersion {
    $nsisVersion =  &"c:\Program Files (x86)\NSIS\makensis.exe" "/Version"
    return "NSIS $nsisVersion"
}

function Get-OpenSSLVersion {
    $(openssl version) -match "OpenSSL (?<version>\d+\.\d+\.\d+\w?) " | Out-Null
    $opensslVersion = $Matches.Version
    return "OpenSSL $opensslVersion"
}

function Get-PackerVersion {
    return "Packer $(packer --version)"
}

function Get-PulumiVersion {
    return "Pulumi $(pulumi version)"
}

function Get-SQLPSVersion {
    $module = Get-Module -Name SQLPS -ListAvailable
    $version = $module.Version
    return "SQLPS $version"
}

function Get-SVNVersion {
    $svnVersion = $(svn --version --quiet)
    return "Subversion (SVN) $svnVersion"
}

function Get-VSWhereVersion {
    ($(Get-Command -Name vswhere).FileVersionInfo.ProductVersion) -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $vswhereVersion = $Matches.Version
    return "VSWhere $vswhereVersion"
}

function Get-WinAppDriver {
    $winAppDriverVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Windows Application Driver\WinAppDriver.exe").FileVersion
    return "WinAppDriver $winAppDriverVersion"
}

function Get-ZstdVersion {
    $(zstd --version) -match "v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $zstdVersion = $Matches.Version
    return "zstd $zstdVersion"
}

function Get-AzureCLIVersion {
    $azureCLIVersion = $(az version) | ConvertFrom-Json | Foreach{ $_."azure-cli" }
    return "Azure CLI $azureCLIVersion"
}

function Get-AzCopyVersion {
    return ($(azcopy --version) -replace "version ")
}

function Get-AzureDevopsExtVersion {
    $azureDevExtVersion = (az version | ConvertFrom-Json | ForEach-Object { $_."extensions" })."azure-devops"
    return "Azure DevOps CLI extension $azureDevExtVersion"
}

function Get-AWSCLIVersion {
    $(aws --version) -match "aws-cli\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $awscliVersion = $Matches.Version
    return "AWS CLI $awscliVersion"
}

function Get-AWSSAMVersion {
    $(sam --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $awssamVersion = $Matches.Version
    return "AWS SAM CLI $awssamVersion"
}

function Get-AWSSessionManagerVersion {
    $awsSessionManagerVersion = $(session-manager-plugin --version)
    return "AWS Session Manager CLI $awsSessionManagerVersion"
}

function Get-AlibabaCLIVersion {
    $alicliVersion = $(aliyun version)
    return "Alibaba Cloud CLI $alicliVersion"
}

function Get-CloudFoundryVersion {
    $(cf version) -match  "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $cfVersion = $Matches.Version
    return "Cloud Foundry CLI $cfVersion"
}

function Get-HubVersion {
    ($(hub version) | Select-String -Pattern "hub version") -match "hub version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $hubVersion = $Matches.Version
    return "Hub CLI $hubVersion"
}

function Get-7zipVersion {
    (7z | Out-String) -match "7-Zip (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $version = $Matches.Version
    return "7zip $version"
}

function Get-GHCVersion {
    ((ghc --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghcVersion = $Matches.Version
    return "ghc $ghcVersion"
}

function Get-CabalVersion {
    ((cabal --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+\.\d+)" | Out-Null
    $cabalVersion = $Matches.Version
    return "Cabal $cabalVersion"
}

function Get-StackVersion {
    ((stack --version --quiet) | Out-String) -match "Version (?<version>\d+\.\d+\.\d+)," | Out-Null
    $stackVersion = $Matches.Version
    return "Stack $stackVersion"
}

function Get-GoogleCloudSDKVersion {
    (gcloud --version) -match "Google Cloud SDK"
}

function Get-NewmanVersion {
    return "Newman $(newman --version)"
}

function Get-GHVersion {
    ($(gh --version) | Select-String -Pattern "gh version") -match "gh version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghVersion = $Matches.Version
    return "GitHub CLI $ghVersion"
}

function Get-VisualCPPComponents {
    $vcpp = Get-CimInstance -ClassName Win32_Product -Filter "Name LIKE 'Microsoft Visual C++%'"
    $vcpp | Sort-Object Name, Version | ForEach-Object {
        $isMatch = $_.Name -match "^(?<Name>Microsoft Visual C\+\+ \d{4})\s+(?<Arch>\w{3})\s+(?<Ext>.+)\s+-"
        if ($isMatch) {
            $name = '{0} {1}' -f $matches["Name"], $matches["Ext"]
            $arch = $matches["Arch"].ToLower()
            $version = $_.Version
            [PSCustomObject]@{
                Name = $name
                Architecture = $arch
                Version = $version
            }
        }
    }
}

function Get-AZDSVersion {
    $azdsVersion = $(azds --version) | Select-String "(\d+\.\d+\.\d+.\d+)"
    return "Azure Dev Spaces CLI $azdsVersion"
}

function Get-DacFxVersion {
    cd "C:\Program Files\Microsoft SQL Server\150\DAC\bin\"
    $dacfxversion = (./sqlpackage.exe /version)
    return "DacFx $dacfxversion"
}