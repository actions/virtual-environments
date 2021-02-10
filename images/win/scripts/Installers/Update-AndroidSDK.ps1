################################################################################
##  File:  Update-AndroidSDK.ps1
##  Desc:  Install and update Android SDK and tools
################################################################################

# Install the standard Android SDK licenses. In the past, there wasn't a better way to do this,
# so we are base64-encoding a zip of the licenses directory from another installation.
# To create this base64 string, create a zip file that contains nothing but a 'licenses' folder,
# which folder contains the accepted license files found in 'C:\Program Files (x86)\Android\android-sdk\licenses'.
# Then, run this in PowerShell:
#     $LicensesZipFileName = 'C:\Program Files (x86)\Android\android-sdk\Licenses.zip'
#     $base64Content = [Convert]::ToBase64String([IO.File]::ReadAllBytes($LicensesZipFileName))
#     echo $base64Content
#
# Future: see if the base64 technique can be avoided by running this PowerShell script to accept all licenses.
# This fails when run on a live agent, likely because non-interactive mode is set.
# It may work fine during image generation (this script).
#     for($i=0; $i -lt 100; $i++) { $response += "y`n"}; $response | .\sdkmanager.bat --licenses
$base64Content = "UEsDBBQAAAAAAKJeN06amkPzKgAAACoAAAAhAAAAbGljZW5zZXMvYW5kcm9pZC1nb29nbGV0di1saWNlbnNlDQpmYzk0NmU4ZjIzMWYzZTMxNTliZjBiN2M2NTVjOTI0Y2IyZTM4MzMwUEsDBBQAAAAIAKBrN05E+YSqQwAAAFQAAAAcAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZQXByREAIQgEwP9WmYsjhxgOKJN/CNs9vmdOQ2zdRw2dxQnWjqQ/3oIgXQM9vqUiwkiX8ljWea4ZlCF3xTo1pz6w+wdQSwMEFAAAAAAAxV43TpECY7AqAAAAKgAAACQAAABsaWNlbnNlcy9hbmRyb2lkLXNkay1wcmV2aWV3LWxpY2Vuc2UNCjUwNDY2N2Y0YzBkZTdhZjFhMDZkZTlmNGIxNzI3Yjg0MzUxZjI5MTBQSwMEFAAAAAAAzF43TpOr0CgqAAAAKgAAABsAAABsaWNlbnNlcy9nb29nbGUtZ2RrLWxpY2Vuc2UNCjMzYjZhMmI2NDYwN2YxMWI3NTlmMzIwZWY5ZGZmNGFlNWM0N2Q5N2FQSwMEFAAAAAAAz143TqxN4xEqAAAAKgAAACQAAABsaWNlbnNlcy9pbnRlbC1hbmRyb2lkLWV4dHJhLWxpY2Vuc2UNCmQ5NzVmNzUxNjk4YTc3YjY2MmYxMjU0ZGRiZWVkMzkwMWU5NzZmNWFQSwMEFAAAAAAA0l43Tu2ee/8qAAAAKgAAACYAAABsaWNlbnNlcy9taXBzLWFuZHJvaWQtc3lzaW1hZ2UtbGljZW5zZQ0KNjNkNzAzZjU2OTJmZDg5MWQ1YWNhY2ZiZDhlMDlmNDBmYzk3NjEwNVBLAQIUABQAAAAAAKJeN06amkPzKgAAACoAAAAhAAAAAAAAAAEAIAAAAAAAAABsaWNlbnNlcy9hbmRyb2lkLWdvb2dsZXR2LWxpY2Vuc2VQSwECFAAUAAAACACgazdORPmEqkMAAABUAAAAHAAAAAAAAAABACAAAABpAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZVBLAQIUABQAAAAAAMVeN06RAmOwKgAAACoAAAAkAAAAAAAAAAEAIAAAAOYAAABsaWNlbnNlcy9hbmRyb2lkLXNkay1wcmV2aWV3LWxpY2Vuc2VQSwECFAAUAAAAAADMXjdOk6vQKCoAAAAqAAAAGwAAAAAAAAABACAAAABSAQAAbGljZW5zZXMvZ29vZ2xlLWdkay1saWNlbnNlUEsBAhQAFAAAAAAAz143TqxN4xEqAAAAKgAAACQAAAAAAAAAAQAgAAAAtQEAAGxpY2Vuc2VzL2ludGVsLWFuZHJvaWQtZXh0cmEtbGljZW5zZVBLAQIUABQAAAAAANJeN07tnnv/KgAAACoAAAAmAAAAAAAAAAEAIAAAACECAABsaWNlbnNlcy9taXBzLWFuZHJvaWQtc3lzaW1hZ2UtbGljZW5zZVBLBQYAAAAABgAGANoBAACPAgAAAAA="
$content = [System.Convert]::FromBase64String($base64Content)
Set-Content -Path .\android-sdk-licenses.zip -Value $content -Encoding Byte
Expand-Archive -Path .\android-sdk-licenses.zip -DestinationPath 'C:\Program Files (x86)\Android\android-sdk' -Force

# run the updates.
# keep newer versions in descending order

# Get android content from toolset
$androidToolset = (Get-ToolsetContent).android

$sdkRoot = "C:\Program Files (x86)\Android\android-sdk"
$sdkManager = "$sdkRoot\tools\bin\sdkmanager.bat"

& $sdkManager --sdk_root=$sdkRoot "platform-tools"

# get packages info
$androidPackages = Get-AndroidPackages -AndroidSDKManagerPath $sdkManager

# platforms
[int]$platformMinVersion = $androidToolset.platform_min_version
$platformList = Get-AndroidPackagesByVersion -AndroidPackages $androidPackages `
                -PrefixPackageName "platforms;" `
                -MinimumVersion $platformMinVersion `
                -Delimiter "-" `
                -Index 1

# build-tools
[version]$buildToolsMinVersion = $androidToolset.build_tools_min_version
$buildToolsList = Get-AndroidPackagesByVersion -AndroidPackages $androidPackages `
                  -PrefixPackageName "build-tools;" `
                  -MinimumVersion $buildToolsMinVersion `
                  -Delimiter ";" `
                  -Index 1

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                          -AndroidSDKRootPath $sdkRoot `
                          -AndroidPackages $platformList

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                          -AndroidSDKRootPath $sdkRoot `
                          -AndroidPackages $buildToolsList

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                          -AndroidSDKRootPath $sdkRoot `
                          -AndroidPackages $androidToolset.extra_list `
                          -PrefixPackageName "extras;"

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                          -AndroidSDKRootPath $sdkRoot `
                          -AndroidPackages $androidToolset.addon_list `
                          -PrefixPackageName "add-ons;"

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                          -AndroidSDKRootPath $sdkRoot `
                          -AndroidPackages $androidToolset.additional_tools

# Android NDK root path.
$ndkRoot = "C:\Program Files (x86)\Android\android-sdk\ndk-bundle"

if (Test-Path $ndkRoot) {
    setx ANDROID_HOME $sdkRoot /M
    setx ANDROID_SDK_ROOT $sdkRoot /M
    setx ANDROID_NDK_HOME $ndkRoot /M
    setx ANDROID_NDK_PATH $ndkRoot /M
} else {
    Write-Host "NDK is not installed at path $ndk_root"
    exit 1
}

Invoke-PesterTests -TestFile "Android"

