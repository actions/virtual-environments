# Toolset JSON structure
## Xcode
- `default` - version of Xcode to set as default  
    **Example:** `"11.2.1"`  

- `versions` - the array of versions of Xcode to install  
    **Example:** `[ "11.3", "11.2.1", "11.2", "11.1", "11" ]`  

## Xamarin
- `vsmac` - version of Visual Studio For Mac to install.  
    **Example:** `"8.3.11.1"`

- `mono-versions` - the array of Mono versions to install.  
    **Example:** `[ "6.4.0.208", "6.0.0.334" ]`  

- `ios-versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "13.6.0.12", "13.4.0.2", "13.2.0.47" ]`  

- `mac-versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "6.6.0.12", "6.4.0.2", "6.2.0.47" ]`  

- `android-versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "10.0.6.2", "9.4.1.0" ]`  

**Note:** More than one version of SDK with the same major.minor version should not be installed. It applies to `mono-versions`, `ios-versions`, `mac-versions`, `android-versions` fields.  
For example, if Mono `6.4.0.100` is installed and Mono `6.4.1.2` was released recently, we should not install both, just update `6.4.0.100` -> `6.4.1.2`. Only major and minor version changes can break backward compatibility so it is safe.  
    
<br>

- `bundle-default` - the symlink of the bundle that will be set as default on the image.  
This bundle will be set as `Current`.  
    **Example:** `"5_12_0"` (set bundle with symlink `5_12_0` as default)  
    **Example:** `"latest"` (set latest bundle as default)  

- `bundles` - the array of objects that describe bundles that will be created on image after sdk installation.  
The first bundle in the list will be as `Latest`.  

    Each object should contain the following fields:
  - `symlink` - unique id of the bundle (usually looks like "<major_mono_version>_<minor_mono_version>_<index>")  
  - `mono` - version of Mono that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `ios` - version of Xamarin.iOS that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `mac` - version of Xamarin.Mac that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `android` - version of Xamarin.Android that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  


    **Example:** 
```
        [
          {
            "symlink": "6_4_2",
            "mono": "6.4",
            "ios": "13.6",
            "mac": "6.6",
            "android": "10.0"
          },
          {
            "symlink": "6_4_1",
            "mono": "6.4",
            "ios": "13.4",
            "mac": "6.4",
            "android": "10.0"
          }
        ]
```

## Android
- `platform-list` - the array of android platforms to install.  
    **Example:** `[ "android-29", "android-28", "android-27" ]`  

- `build-tools` - the array of android build tools to install.  
    **Example:** `[ "29.0.2", "29.0.1", "29.0.0", "28.0.3" ]`  

- `extra-list` - the array of android extra items to install.  
    **Example:** `[ "google;google_play_services", "intel;Hardware_Accelerated_Execution_Manager" ]`  

- `addon-list` - the array of android addons to install.  
    **Example:** `[ "addon-google_apis-google-24", "addon-google_apis-google-23" ]`  


# Toolset JSON validation
File `Toolset.Tests.ps1` contains PowerShell [Pester](https://github.com/Pester/Pester) tests that validate JSON toolset files.
Type `Invoke-Pester` in the current folder in PowerShell to run tests.