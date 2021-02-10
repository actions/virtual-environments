################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

function getSimpleValue([string] $url, [string] $filename ) {
    $fullpath = "${env:Temp}\$filename"
    Invoke-WebRequest -Uri $url -OutFile $fullpath
    $value = Get-Content $fullpath -Raw

    return $value
}

# Install the latest version of Git for Windows
$gitTag = getSimpleValue -url "https://gitforwindows.org/latest-tag.txt" -filename "gitlatesttag.txt"
$gitVersion = getSimpleValue -url "https://gitforwindows.org/latest-version.txt" -filename "gitlatestversion.txt";

$installerFile = "Git-$gitVersion-64-bit.exe";
$downloadUrl = "https://github.com/git-for-windows/git/releases/download/$gitTag/$installerFile";
Install-Binary  -Url $downloadUrl `
                -Name $installerFile `
                -ArgumentList (
                    "/VERYSILENT", `
                    "/NORESTART", `
                    "/NOCANCEL", `
                    "/SP-", `
                    "/CLOSEAPPLICATIONS", `
                    "/RESTARTAPPLICATIONS", `
                    "/o:PathOption=CmdTools", `
                    "/o:BashTerminalOption=ConHost", `
                    "/o:EnableSymlinks=Enabled", `
                    "/COMPONENTS=gitlfs")

Choco-Install -PackageName hub

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

Add-MachinePathItem "C:\Program Files\Git\bin"

if (Test-IsWin16) {
    $env:Path += ";$env:ProgramFiles\Git\usr\bin\"
}

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git" -TestName "Git"
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Hub CLI"
