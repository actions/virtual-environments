################################################################################
##  File:  Install-MysqlCli.ps1
##  Desc:  Install Mysql CLI
################################################################################

## Downloading mysql jar
$MysqlVersionName = "mysql-5.7.21-winx64"
$MysqlVersionUrl = "https://dev.mysql.com/get/Downloads/MySQL-5.7/${MysqlVersionName}.zip"
$MysqlPath = "C:\$MysqlVersionName\bin"

# Installing visual c++ redistibutable package.
$InstallerName = "vcredist_x64.exe"
$InstallerURI = "https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/${InstallerName}"
$ArgumentList = ("/install", "/quiet", "/norestart")

Install-Binary -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList

# MySQL disabled TLS 1.0 support on or about Jul-14-2018.  Need to make sure TLS 1.2 is enabled.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

# Get the latest mysql command line tools .
$mysqlArchPath = Start-DownloadWithRetry -Url $MysqlVersionUrl -Name "mysql.zip"

# Expand the zip
Extract-7Zip -Path $mysqlArchPath -DestinationPath "C:\"

# Adding mysql in system environment path
Add-MachinePathItem $mysqlPath

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"