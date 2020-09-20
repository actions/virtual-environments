################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
################################################################################

Import-Module -Name ImageHelpers -Force

function Set-JavaPath {
    param (
        [string] $Version,
        [string] $JavaRootPath,
        [switch] $Default
    )

    if ($Version -eq 7) {
        $matchedString = "azure-jdk_7"
    } else {
        $matchedString = "jdk-?$Version"
    }
    $javaPath = (Get-ChildItem -Path $JavaRootPath | Where-Object { $_ -match $matchedString}).FullName

    if ([string]::IsNullOrEmpty($javaPath)) {
        Write-Host "Not found path to Java $Version"
        exit 1
    }

    Write-Host "Set JAVA_HOME_${Version}_X64 environmental variable as $javaPath"
    setx JAVA_HOME_${Version}_X64 $javaPath /M

    if ($Default)
    {
        $currentPath = Get-MachinePath

        $pathSegments = $currentPath.Split(';')
        $newPathSegments = @()

        foreach ($pathSegment in $pathSegments)
        {
            if ($pathSegment -notlike '*java*')
            {
                $newPathSegments += $pathSegment
            }
        }

        $newPath = [string]::Join(';', $newPathSegments)
        $newPath = $javaPath + '\bin;' + $newPath

        Write-Host "Add $javaPath\bin to PATH"
        Set-MachinePath -NewPath $newPath

        Write-Host "Set JAVA_HOME environmental variable as $javaPath"
        setx JAVA_HOME $javaPath /M
    }
}

function Install-Java7FromAzul {
    param(
        [string] $DestinationPath
    )
    $azulJDK7URL = 'https://repos.azul.com/azure-only/zulu/packages/zulu-7/7u232/zulu-7-azure-jdk_7.31.0.5-7.0.232-win_x64.zip'
    $archivePath = Start-DownloadWithRetry -Url $azulJDK7URL -Name $([IO.Path]::GetFileName($azulJDK7URL))
    Extract-7Zip -Path $archivePath -DestinationPath $DestinationPath
}

function Install-JavaFromAdoptOpenJDK {
    param(
        [string] $JDKVersion,
        [string] $DestinationPath
    )

    $assets = Invoke-RestMethod -Uri "https://api.adoptopenjdk.net/v3/assets/latest/$JDKVersion/hotspot"
    $downloadUrl = ($assets | Where-Object {
        $_.binary.os -eq "windows" `
        -and $_.binary.architecture -eq "x64" `
        -and $_.binary.image_type -eq "jdk"
    }).binary.package.link

    $archivePath = Start-DownloadWithRetry -Url $downloadUrl -Name $([IO.Path]::GetFileName($downloadUrl))
    Extract-7Zip -Path $archivePath -DestinationPath $DestinationPath
}

$jdkVersions = @(7, 8, 11, 13)
$defaultVersion = 8
$javaRootPath = "C:\Program Files\Java\"

foreach ($jdkVersion in $jdkVersions) {
    if ($jdkVersion -eq 7) {
        Install-Java7FromAzul -DestinationPath $javaRootPath
    } else {
        Install-JavaFromAdoptOpenJDK -JDKVersion $jdkVersion -DestinationPath $javaRootPath
    }

    if ($jdkVersion -eq $defaultVersion) {
        Set-JavaPath -Version $jdkVersion -JavaRootPath $javaRootPath -Default
    } else {
        Set-JavaPath -Version $jdkVersion -JavaRootPath $javaRootPath
    }
}

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
Choco-Install -PackageName ant -ArgumentList "-i"
Choco-Install -PackageName maven -ArgumentList "-i", "--version=3.6.3"
Choco-Install -PackageName gradle

# Move maven variables to Machine. They may not be in the environment for this script so we need to read them from the registry.
$userEnvironmentKey = 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'

$m2_home = (Get-ItemProperty -Path $userEnvironmentKey -Name M2_HOME).M2_HOME
$m2 = $m2_home + '\bin'
$maven_opts = '-Xms256m'

$m2_repo = 'C:\ProgramData\m2'
New-Item -Path $m2_repo -ItemType Directory -Force

setx M2 $m2 /M
setx M2_HOME $m2_home /M
setx M2_REPO $m2_repo /M
setx MAVEN_OPTS $maven_opts /M

# Download cobertura jars
$uri = 'https://downloads.sourceforge.net/project/cobertura/cobertura/2.1.1/cobertura-2.1.1-bin.zip'
$coberturaPath = "C:\cobertura-2.1.1"

$archivePath = Start-DownloadWithRetry -Url $uri -Name "cobertura.zip"
Extract-7Zip -Path $archivePath -DestinationPath "C:\"

setx COBERTURA_HOME $coberturaPath /M

Invoke-PesterTests -TestFile "Java"