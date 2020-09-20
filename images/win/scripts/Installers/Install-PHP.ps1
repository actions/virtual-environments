################################################################################
##  File:  Install-PHP.ps1
##  Desc:  Install PHP
################################################################################
$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

# Install latest PHP in chocolatey
$installDir = "c:\tools\php"
Choco-Install -PackageName php -ArgumentList "--force", "--params", "/InstallDir:$installDir"

# Install latest Composer in chocolatey
Choco-Install -PackageName composer -ArgumentList "--ia", "/DEV=$installDir /PHP=$installDir"

# update path to extensions and enable curl and mbstring extensions, and enable php openssl extensions.
((Get-Content -path $installDir\php.ini -Raw) -replace ';extension=curl','extension=curl' -replace ';extension=mbstring','extension=mbstring' -replace ';extension_dir = "ext"','extension_dir = "ext"' -replace 'extension=";php_openssl.dll"','extension_dir = "php_openssl.dll"') | Set-Content -Path $installDir\php.ini

# Set the PHPROOT environment variable.
setx PHPROOT $installDir /M

# Invoke Pester Tests
Invoke-PesterTests -TestFile "PHP"
