################################################################################
##  File:  Install-ServiceFabricSDK.ps1
##  Desc:  Install webpicmd and then the service fabric sdk
##         must be install after Visual Studio
################################################################################

#Creating 'Installer' cache folder if it doesn't exist
$temp_install_dir = 'C:\Windows\Installer'
New-Item -Path $temp_install_dir -ItemType Directory -Force

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

WebpiCmd.exe /Install /Products:MicrosoftAzure-ServiceFabric-CoreSDK /AcceptEula /XML:https://webpifeed.blob.core.windows.net/webpifeed/5.1/WebProductList.xml

Invoke-PesterTests -TestFile "Tools" -TestName "ServiceFabricSDK"
