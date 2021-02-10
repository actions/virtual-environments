################################################################################
##  File:  Install-GoogleCloudSDK.ps1
##  Desc:  Install Google Cloud SDK
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
$googleCloudSDKInstaller = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
$argumentList = @("/S", "/allusers", "/noreporting")
Install-Binary -Url $googleCloudSDKInstaller -Name "GoogleCloudSDKInstaller.exe" -ArgumentList $argumentList

Invoke-PesterTests -TestFile "Tools" -TestName "GoogleCloudSDK"
