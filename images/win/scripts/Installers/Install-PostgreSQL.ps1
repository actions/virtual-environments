#Define user and password for PostgreSQL database
$pgUser = "postgres"
$pgPwd = "root"

#Prepare environment variable for validation
Set-SystemVariable -SystemVariable PGUSER -Value $pgUser
Set-SystemVariable -SystemVariable PGPASSWORD -Value $pgPwd

#Install latest PostgreSQL
Choco-Install -PackageName postgresql -ArgumentList "--params", "'/Password:$pgPwd /NoPath'", "--params-global", "--debug", "--verbose"

#Get Path to pg_ctl.exe
$pgPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName

#Parse output of command above to obtain pure path
$pgBin = Split-Path -Path $pgPath.split('"')[1]
$pgRoot = Split-Path -Path $pgPath.split('"')[5]
$pgData = Join-Path $pgRoot "data"

#Validate PostgreSQL installation
$pgReadyPath = Join-Path $pgBin "pg_isready.exe"
$pgReady = Start-Process -FilePath $pgReadyPath -Wait -PassThru
$exitCode = $pgReady.ExitCode

if ($exitCode -ne 0)
{
    Write-Host -Object "PostgreSQL is not ready. Exitcode: $exitCode"
    exit $exitCode
}

#Added PostgreSQL environment variable
Set-SystemVariable -SystemVariable PGBIN -Value $pgBin
Set-SystemVariable -SystemVariable PGROOT -Value $pgRoot
Set-SystemVariable -SystemVariable PGDATA -Value $pgData

#Stop and disable PostgreSQL service
$pgService = Get-Service -Name postgresql*
Stop-Service -InputObject $pgService
Set-Service -InputObject $pgService -StartupType Disabled

Invoke-PesterTests -TestFile "Databases" -TestName "PostgreSQL"