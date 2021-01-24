| Announcements |
|-|
| [[ubuntu, windows] Default Go version will be set to 1.15 on February, 8](https://github.com/actions/virtual-environments/issues/2447) |
| [[all OSs] Java 7 will be removed from images on February, 8.](https://github.com/actions/virtual-environments/issues/2446) |
| [[all OS versions] Android NDK is updated to r22.](https://github.com/actions/virtual-environments/issues/2420) |
| [[Windows] Default PHP is set to 8.0](https://github.com/actions/virtual-environments/issues/2416) |
***
# Microsoft Windows Server 2019 Datacenter
- OS Version: 10.0.17763 Build 1697
- Image Version: 20210121.0

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.14.14
- Julia 1.5.3
- Node 14.15.4
- Perl 5.32.0
- PHP 8.0.1
- Python 3.7.9
- Ruby 2.5.8p224

### Package Management
- Chocolatey 0.10.15
- Composer 2.0.8
- Helm 3.5.0
- Miniconda 4.9.2
- NPM 6.14.10
- NuGet 5.8.1.7021
- pip 20.3.3 (python 3.7)
- Pipx 0.16.0.0
- RubyGems 2.7.6.2
- Vcpkg  (build from master \<5065bf9>)
- Yarn 1.22.10

### Project Management
- Ant 1.10.9
- Gradle 6.8
- Maven 3.6.3
- sbt 1.4.5

### Tools
- 7zip 19.00
- azcopy 10.8.0
- Bazel 4.0.0
- Bazelisk 1.7.3
- Cabal 3.2.0.0
- CMake 3.19.3
- CodeQL Action Bundle 2.4.0
- Docker 19.03.14
- Docker-compose 1.27.4
- ghc 8.10.3
- Git 2.30.0
- Git LFS 2.13.2
- Google Cloud SDK 324.0.0
- InnoSetup 6.1.2
- jq 1.6
- Kind 0.9.0
- Kubectl 1.20.2
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.2.2
- NSIS v3.06.1
- OpenSSL 1.1.1
- Packer 1.6.6
- Pulumi v2.18.0
- R 4.0.3
- Stack 2.5.1
- Subversion (SVN) 1.14.0
- VSWhere 2.8.4
- WinAppDriver 1.2.2009.02003
- yamllint 1.25.0
- zstd 1.4.5

### CLI Tools
- Alibaba Cloud CLI 3.0.66
- AWS CLI 2.1.20
- AWS SAM CLI 1.15.0
- AWS Session Manager CLI 1.2.30.0
- Azure CLI 2.18.0
- Azure Dev Spaces CLI 1.0.20201219.2
- Azure DevOps CLI extension 0.18.0
- Cloud Foundry CLI 6.53.0
- GitHub CLI 1.5.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.49.0
- Rust 1.49.0
- Rustdoc 1.49.0
- Rustup 1.23.1

#### Packages
- bindgen 0.56.0
- cargo-audit 0.13.1
- cargo-outdated v0.9.13
- cbindgen 0.16.0
- Clippy 0.0.212
- Rustfmt 1.4.25

### Browsers and webdrivers
- Google Chrome 88.0.4324.104
- Chrome Driver 88.0.4324.96
- Microsoft Edge 87.0.664.75
- Microsoft Edge Driver 87.0.664.75
- Mozilla Firefox 84.0.2
- Gecko Driver 0.29.0
- IE Driver 3.150.1.0

### Java
| Version             | Vendor       | Environment Variable |
| ------------------- | ------------ | -------------------- |
| 1.7.0_232           | Zulu         | JAVA_HOME_7_X64      |
| 1.8.0_282 (default) | AdoptOpenJDK | JAVA_HOME_8_X64      |
| 11.0.9.1            | AdoptOpenJDK | JAVA_HOME_11_X64     |
| 13.0.2              | AdoptOpenJDK | JAVA_HOME_13_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\windows\System32\bash.exe      |

### MSYS2
- Pacman 5.2.2
##### Notes:
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
### BizTalk Server
- BizTalk Server Project Build Component 3.13.765.0 
### Cached Tools
#### Boost
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.72.0  | x64, x86     | BOOST_ROOT_1_72_0    |
##### Notes:
```
1. Environment variable "BOOST_ROOT" is not set by default.
   Please make sure you set this variable value to proper value
   from table above depending on the Boost version you are using.
2. If Boost was built using the boost-cmake project or from Boost 1.70.0
   on it provides a package configuration file for use with find_package's config mode.
   This module looks for the package configuration file called BoostConfig.cmake or boost-config.cmake
   and stores the result in CACHE entry "Boost_DIR". If found, the package configuration file
   is loaded and this module returns with no further action.
   See documentation of the Boost CMake package configuration for details on what it provides.
   Set Boost_NO_BOOST_CMAKE to ON, to disable the search for boost-cmake.
   Link: https://cmake.org/cmake/help/latest/module/FindBoost.html
```

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.13.15 | x64          | GOROOT_1_13_X64      |
| 1.14.14 (Default) | x64          | GOROOT_1_14_X64      |
| 1.15.7  | x64          | GOROOT_1_15_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 10.23.1 | x64          |
| 12.20.1 | x64          |
| 14.15.4 | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.9 (Default) | x64, x86     |
| 3.8.7   | x64, x86     |
| 3.9.1   | x64, x86     |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.4.10  | x64          |
| 2.5.8 (Default) | x64          |
| 2.6.6   | x64          |
| 2.7.2   | x64          |
| 3.0.0   | x64          |


#### PyPy
| Python Version | Architecture | PyPy Version |
| -------------- | ------------ | ------------ |
| 2.7.18         | x86          | PyPy 7.3.3 with MSC v.1927 32 bit |
| 3.6.12         | x86          | PyPy 7.3.3 with MSC v.1927 32 bit |



### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-13                                                                                                                    |
| Version              | 13.1                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\13\bin <br> PGDATA=C:\Program Files\PostgreSQL\13\data <br> PGROOT=C:\Program Files\PostgreSQL\13  |
| Path                 | C:\Program Files\PostgreSQL\13                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 4.4.3.0 | MongoDB     | Running       | Automatic        |



### Database tools
- Azure CosmosDb Emulator 2.11.10.0
- DacFx 15.0.4897.1
- MySQL 5.7.21.0
- SQLPS 1.0


### Visual Studio Enterprise 2019
| Name                          | Version        | Path                                                           |
| ----------------------------- | -------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2019 | 16.8.30907.101 | C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise |

#### Workloads, components and extensions:

| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R16B                                                | 16.8.30907.39  |
| Component.Android.SDK25.Private                                           | 16.0.28625.61  |
| Component.Android.SDK28                                                   | 16.2.29003.222 |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Dotfuscator                                                     | 16.0.28528.71  |
| Component.Linux.CMake                                                     | 16.2.29003.222 |
| Component.MDD.Android                                                     | 16.0.28517.75  |
| Component.MDD.Linux                                                       | 16.5.29515.121 |
| Component.MDD.Linux.GCC.arm                                               | 16.5.29515.121 |
| Component.Microsoft.VisualStudio.LiveShare                                | 1.0.3224       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 16.0.28714.129 |
| Component.Microsoft.VisualStudio.Tools.Applications                       | 16.0.29425.2   |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 16.0.28714.129 |
| Component.Microsoft.Web.LibraryManager                                    | 16.0.28315.86  |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.19030.0   |
| Component.OpenJDK                                                         | 16.1.28811.260 |
| Component.UnityEngine.x64                                                 | 16.8.30509.167 |
| Component.Unreal                                                          | 16.1.28810.153 |
| Component.Unreal.Android                                                  | 16.1.28810.153 |
| Component.VSInstallerProjects                                             | 0.9.9          |
| Component.WixToolset.VisualStudioExtension.Dev16                          | 1.0.0.4        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.4        |
| Component.WixToolset.VisualStudioExtension.Schemas4                       | 1.0.0.4        |
| Component.Xamarin                                                         | 16.8.30509.167 |
| Component.Xamarin.RemotedSimulator                                        | 16.8.30509.167 |
| Microsoft.Component.Azure.DataLake.Tools                                  | 16.8.30509.167 |
| Microsoft.Component.ClickOnce                                             | 16.4.29409.204 |
| Microsoft.Component.MSBuild                                               | 16.5.29515.121 |
| Microsoft.Component.NetFX.Native                                          | 16.5.29515.121 |
| Microsoft.Component.PythonTools                                           | 16.5.29515.121 |
| Microsoft.Component.PythonTools.Miniconda                                 | 16.2.29003.222 |
| Microsoft.Component.PythonTools.Web                                       | 16.0.28517.75  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 16.0.28625.61  |
| Microsoft.ComponentGroup.Blend                                            | 16.0.28315.86  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 16.8.30622.256 |
| Microsoft.Net.Component.3.5.DeveloperTools                                | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.1.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.TargetingPack                                 | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.1.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 16.0.28517.75  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 16.8.30509.167 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 16.4.29409.204 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 16.8.30509.167 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 16.8.30509.167 |
| Microsoft.Net.Component.4.8.SDK                                           | 16.4.29313.120 |
| Microsoft.Net.Component.4.TargetingPack                                   | 16.0.28517.75  |
| Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools                         | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools                         | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.4.7.DeveloperTools                           | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 16.0.28516.191 |
| Microsoft.Net.Core.Component.SDK.2.1                                      | 16.8.30907.39  |
| Microsoft.NetCore.Component.DevelopmentTools                              | 16.8.30607.99  |
| Microsoft.NetCore.Component.Runtime.3.1                                   | 16.8.30907.39  |
| Microsoft.NetCore.Component.Runtime.5.0                                   | 16.8.30907.39  |
| Microsoft.NetCore.Component.SDK                                           | 16.8.30907.39  |
| Microsoft.NetCore.Component.Web                                           | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Azure.Kubernetes.Tools                   | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.Azure.Storage.AzCopy                     | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Azure.Storage.Emulator                   | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 16.0.28528.71  |
| Microsoft.VisualStudio.Component.CloudExplorer                            | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 16.1.28811.260 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 16.5.29813.82  |
| Microsoft.VisualStudio.Component.Debugger.TimeTravel                      | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.DockerTools                              | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.DslTools                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp                                   | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Graphics                                 | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.IISExpress                               | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 16.8.30907.39  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 16.4.29318.151 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 16.8.30607.99  |
| Microsoft.VisualStudio.Component.Merq                                     | 16.2.29012.281 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 16.0.28707.177 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.NuGet                                    | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 16.0.28714.129 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.SQL.ADAL                                 | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 16.0.28327.66  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.TypeScript.4.0                           | 16.0.30509.167 |
| Microsoft.VisualStudio.Component.Unity                                    | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.VC.14.25.x86.x64                         | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.140                                   | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 16.3.29103.31  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 16.8.30712.155 |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM.Spectre                  | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM64.Spectre                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM.Spectre                  | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM64.Spectre                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Web                                      | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.Windows10SDK.16299                       | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Windows10SDK.17134                       | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.Windows10SDK.17763                       | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Windows10SDK.18362                       | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 16.8.30509.167 |
| Microsoft.VisualStudio.Component.WinXP                                    | 16.1.28811.260 |
| Microsoft.VisualStudio.Component.Workflow                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 16.0.28621.142 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 16.4.29409.204 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 16.8.30509.167 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 16.0.28528.71  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 16.0.28621.142 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 16.8.30607.99  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 16.2.29012.281 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 16.8.30509.167 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 16.3.29102.218 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 16.4.29409.204 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC                              | 16.8.30607.99  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 16.8.30607.99  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 16.4.29318.151 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 16.4.29318.151 |
| Microsoft.VisualStudio.ComponentGroup.Web.Client                          | 16.8.30607.99  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 16.2.29003.222 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 16.8.30509.167 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 16.3.29207.166 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 16.0.28315.86  |
| Microsoft.VisualStudio.Workload.Azure                                     | 16.4.29409.204 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 16.0.28315.86  |
| Microsoft.VisualStudio.Workload.Data                                      | 16.0.28720.110 |
| Microsoft.VisualStudio.Workload.DataScience                               | 16.0.28720.110 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 16.8.30509.167 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 16.4.29409.204 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 16.8.30530.185 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 16.8.30530.185 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NetCoreTools                              | 16.8.30509.167 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 16.8.30509.167 |
| Microsoft.VisualStudio.Workload.Node                                      | 16.1.28825.262 |
| Microsoft.VisualStudio.Workload.Office                                    | 16.3.29207.166 |
| Microsoft.VisualStudio.Workload.Python                                    | 16.0.28621.142 |
| Microsoft.VisualStudio.Workload.Universal                                 | 16.8.30530.185 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 16.4.29409.204 |
| SSDT Microsoft Analysis Services Projects                                 | 2.9.15         |
| SSDT SQL Server Integration Services Projects                             | 3.11.1         |
| SSDT Microsoft Reporting Services Projects                                | 2.6.7          |
| Windows Driver Kit                                                        | 3.11.4516      |
| Windows Driver Kit Visual Studio Extension                                | 10.1.19041.685 |
| WIX Toolset                                                               | 3.11.4516      |
| WIX Toolset Studio 2019 Extension                                         | 1.0.0.4        |

#### Microsoft Visual C++:

| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2010 Redistributable    | x64          | 10.0.40219  |
| Microsoft Visual C++ 2010 Redistributable    | x86          | 10.0.40219  |
| Microsoft Visual C++ 2012 Additional Runtime | x64          | 11.0.61030  |
| Microsoft Visual C++ 2012 Minimum Runtime    | x64          | 11.0.61030  |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Additional Runtime | x86          | 12.0.21005  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x86          | 12.0.21005  |
| Microsoft Visual C++ 2019 Additional Runtime | x64          | 14.28.29334 |
| Microsoft Visual C++ 2019 Debug Runtime      | x64          | 14.28.29334 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x64          | 14.28.29334 |
| Microsoft Visual C++ 2019 Additional Runtime | x86          | 14.28.29334 |
| Microsoft Visual C++ 2019 Debug Runtime      | x86          | 14.28.29334 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x86          | 14.28.29334 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 5.0.100 5.0.101 5.0.102

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.1.1

#### Azure Powershell Modules
| Module  | Version                                                                                         | Path                           |
| ------- | ----------------------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0<br>1.6.0<br>2.3.2<br>2.6.0<br>3.1.0<br>3.5.0<br>3.8.0<br>4.3.0<br>4.4.0<br>4.6.0<br>4.7.0 | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>5.3.0                                           | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>6.7.0<br>6.13.1                                 | C:\Modules\azurerm_\<version\> |
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
#### Powershell Modules
| Module             | Version          |
| ------------------ | ---------------- |
| DockerMsftProvider | 1.0.0.8          |
| MarkdownPS         | 1.9              |
| Pester             | 3.4.0<br>5.1.1   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSWindowsUpdate    | 2.2.0.2          |
| SqlServer          | 21.1.18235       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 3.0                                                                                                                                                                                                                                                                                   |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3<br>22.0.1<br>21.1.2<br>20.0.0<br>19.1.0 |
| Android SDK Platforms      | android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)<br>android-22 (rev 2)<br>android-21 (rev 2)<br>android-20 (rev 2)<br>android-19 (rev 4)                  |
| Android SDK Platform-Tools | 30.0.5                                                                                                                                                                                                                                                                                |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                |
| CMake                      | 3.10.2<br>3.6.4111459                                                                                                                                                                                                                                                                 |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                              |
| Google Play services       | 49                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                    |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                     |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019  | sha256:73662be18cede0efb5fd6b79bf9b60b2f16f9e39d606463d36be811942576dcd  | 2021-01-12 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019 | sha256:8a3e3cac97f04de4683e0f54f9a2be97c1fd4f92f76ac30449f34d18eafb4f28  | 2021-01-12 |
| mcr.microsoft.com/windows/servercore:ltsc2019                             | sha256:997e32161f322f5f301023ae675f39329bd60888f5f9a373100eba77f55cbb31  | 2021-01-08 |
| mcr.microsoft.com/windows/nanoserver:1809                                 | sha256:58157fff3c3cfec14b102082474e62fb01d54cc6594973dd0038bce979ec8161  | 2021-01-07 |
| microsoft/aspnetcore-build:1.0-2.0                                        | sha256:9ecc7c5a8a7a11dca5f08c860165646cb30d084606360a3a72b9cbe447241c0c  | 2018-08-15 |



