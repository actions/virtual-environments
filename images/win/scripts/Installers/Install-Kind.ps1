################################################################################
##  File:  Install-Kind.ps1
##  Desc:  Install Kind
################################################################################

function Get-LatestRelease
{
    $url = 'https://api.github.com/repos/kubernetes-sigs/kind/releases/latest'
    (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "kind-windows-amd64"
}

try
{
    Write-Host "Starting Install kind.exe..."
    $destFilePath = "C:\ProgramData\kind"
    $null = New-Item -Path $destFilePath -ItemType Directory -Force

    $kindUrl = Get-LatestRelease
    $kindInstallerPath = Start-DownloadWithRetry -Url $kindUrl -Name "kind.exe" -DownloadPath $destFilePath

    $process = Start-Process -FilePath $kindInstallerPath -Wait -PassThru
    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 3010)
    {
        Write-Host 'Installation successful'
        Add-MachinePathItem $destFilePath
    }
    else
    {
        Write-Host "Non zero exit code returned by the installation process : $exitCode."
        exit $exitCode
    }
}
catch
{
    Write-Host "Failed to install the Executable kind.exe"
    Write-Host $_.Exception.Message
    exit 1
}

Invoke-PesterTests -TestFile "Tools" -TestName "Kind"