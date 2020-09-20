| Announcements |
|-|
| [Replace SVN (1.8.17) by TortoiseSVN (1.14.x) on Windows images](https://github.com/actions/virtual-environments/issues/1318) |
***
# Microsoft Windows Server 2019 Datacenter
- OS Version: 10.0.17763 Build 1397
- Image Version: 20200827.1

## Enabled windows optional features
- Windows Subsystem for Linux

## Installed Software
### Language and Runtime
- Java 1.7.0_232 
- Java 1.8.0_265 (default)
- Java 11.0.8 
- Java 13.0.2 
- Python 3.7.9
- Ruby 2.5.8p224
- Go 1.14.7
- PHP 7.4.9
- Julia 1.5.1
- Perl 5.30.3
- Node 12.18.3

### Package Management
- Chocolatey 0.10.15
- Vcpkg 2020.06.15
- NPM 6.14.6
- Yarn 1.22.4
- pip 20.2.2 (python 3.7)
- Miniconda 4.6.14
- RubyGems 3.1.4
- Helm 3.3.0
- Composer 1.10.10
- NuGet 5.7.0.6726

### Project Management
- Ant 1.10.5
- Maven 3.6.3
- Gradle 6.6
- sbt 1.3.13

### Tools
- Azure CosmosDb Emulator 2.11.5.0
- azcopy 10.6.0
- Bazel 3.4.1
- Bazelisk 1.6.1
- CMake 3.18.2
- R 4.0.2
- Docker 19.03.11
- Docker-compose 1.26.2
- Git 2.28.0
- Git LFS 2.11.0
- Google Cloud SDK 307.0.0
- InnoSetup 6.0.5
- jq 1.6
- Kubectl 1.18.8
- Kind 0.8.1
- Mingw-w64 8.1.0
- MySQL 5.7.21.0
- Mercurial 5.0
- NSIS v3.06.1
- Newman 5.1.2
- OpenSSL 1.1.1
- Packer 1.6.1
- SQLPS 1.0
- SQLServer PS 21.1.18226
- Subversion (SVN) 1.14.0
- ghc 8.10.2
- Cabal 3.2.0.0
- Stack 2.3.3
- WinAppDriver 1.1.1809.18001
- zstd 1.4.0
- VSWhere 2.8.4
- 7zip 19.00
- yamllint 1.24.2

### CLI Tools
- Azure CLI 2.11.0
- Azure DevOps CLI extension 0.18.0
- AWS CLI 2.0.43
- AWS SAM CLI 1.1.0
- AWS Session Manager CLI 1.1.61.0
- Alibaba Cloud CLI 3.0.56
- Cloud Foundry CLI 6.52.0
- Hub CLI 2.14.2
- GitHub CLI gh version 0.11.1 (2020-07-28) https://github.com/cli/cli/releases/tag/v0.11.1

### Rust Tools
- Rust 1.45.2

#### Packages
- bindgen 0.55.1
- cbindgen 0.14.4
- cargo-audit 0.12.0
- cargo-outdated v0.9.11

### Browsers and webdrivers
- Google Chrome 85.0.4183.83
- Chrome Driver 85.0.4183.83
- Microsoft Edge 84.0.522.63
- Microsoft Edge Driver 84.0.522.63
- Mozilla Firefox 80.0
- Gecko Driver 0.27.0
- IE Driver 3.150.1.0

### MSYS2
- Pacman 5.2.2
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
### Cached Tools
#### Boost
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.69.0  | x64, x86     | BOOST_ROOT_1_69_0    |
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
| 1.9.7   | x64          | GOROOT_1_9_X64       |
| 1.10.8  | x64          | GOROOT_1_10_X64      |
| 1.11.13 | x64          | GOROOT_1_11_X64      |
| 1.12.17 | x64          | GOROOT_1_12_X64      |
| 1.13.15 | x64          | GOROOT_1_13_X64      |
| 1.14.7 (Default) | x64          | GOROOT_1_14_X64      |
| 1.15.0  | x64          | GOROOT_1_15_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 8.17.0  | x64          |
| 10.22.0 | x64          |
| 12.18.3 | x64          |
| 14.8.0  | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.9 (Default) | x64, x86     |
| 3.8.5   | x64, x86     |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.4.10  | x64          |
| 2.5.8 (Default) | x64          |
| 2.6.6   | x64          |
| 2.7.1   | x64          |


#### PyPy
| Python Version | Architecture | PyPy Version |
| -------------- | ------------ | ------------ |
| 2.7.13         | x86          | PyPy 7.3.1 with MSC v.1912 32 bit |
| 3.6.9          | x86          | PyPy 7.3.1 with MSC v.1912 32 bit |



### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-12                                                                                                                    |
| Version              | 12.4                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\12\bin <br> PGDATA=C:\Program Files\PostgreSQL\12\data <br> PGROOT=C:\Program Files\PostgreSQL\12  |
| Path                 | C:\Program Files\PostgreSQL\12                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 4.4.0.0 | MongoDB     | Running       | Automatic        |



### Visual Studio Enterprise 2019
| Name                          | Version        | Path                                                           |
| ----------------------------- | -------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2019 | 16.7.30413.136 | C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise |

#### Workloads, components and extensions:

| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R16B                                                | 16.7.30411.121 |
| Component.Android.SDK25.Private                                           | 16.0.28625.61  |
| Component.Android.SDK28                                                   | 16.2.29003.222 |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Dotfuscator                                                     | 16.0.28528.71  |
| Component.Linux.CMake                                                     | 16.2.29003.222 |
| Component.MDD.Android                                                     | 16.0.28517.75  |
| Component.MDD.Linux                                                       | 16.5.29515.121 |
| Component.MDD.Linux.GCC.arm                                               | 16.5.29515.121 |
| Component.Microsoft.VisualStudio.LiveShare                                | 1.0.2518       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 16.0.28714.129 |
| Component.Microsoft.VisualStudio.Tools.Applications                       | 16.0.29425.2   |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 16.0.28714.129 |
| Component.Microsoft.Web.LibraryManager                                    | 16.0.28315.86  |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.19030.0   |
| Component.OpenJDK                                                         | 16.1.28811.260 |
| Component.UnityEngine.x64                                                 | 16.7.30310.162 |
| Component.Unreal                                                          | 16.1.28810.153 |
| Component.Unreal.Android                                                  | 16.1.28810.153 |
| Component.WixToolset.VisualStudioExtension.Dev16                          | 1.0.0.4        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.4        |
| Component.WixToolset.VisualStudioExtension.Schemas4                       | 1.0.0.4        |
| Component.Xamarin                                                         | 16.7.30310.162 |
| Component.Xamarin.RemotedSimulator                                        | 16.0.28315.86  |
| Microsoft.Component.Azure.DataLake.Tools                                  | 16.7.30310.162 |
| Microsoft.Component.MSBuild                                               | 16.5.29515.121 |
| Microsoft.Component.NetFX.Native                                          | 16.5.29515.121 |
| Microsoft.Component.PythonTools                                           | 16.5.29515.121 |
| Microsoft.Component.PythonTools.Miniconda                                 | 16.2.29003.222 |
| Microsoft.Component.PythonTools.Web                                       | 16.0.28517.75  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 16.0.28625.61  |
| Microsoft.ComponentGroup.Blend                                            | 16.0.28315.86  |
| Microsoft.Net.Component.3.5.DeveloperTools                                | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.1.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.5.TargetingPack                                 | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.1.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 16.0.28517.75  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 16.0.28517.75  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 16.7.30310.162 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 16.4.29409.204 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 16.7.30310.162 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 16.7.30310.162 |
| Microsoft.Net.Component.4.8.SDK                                           | 16.4.29313.120 |
| Microsoft.Net.Component.4.TargetingPack                                   | 16.0.28517.75  |
| Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools                         | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools                         | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.4.7.DeveloperTools                           | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 16.3.29207.166 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 16.0.28516.191 |
| Microsoft.Net.Core.Component.SDK.2.1                                      | 16.7.30406.193 |
| Microsoft.NetCore.Component.DevelopmentTools                              | 16.5.29721.120 |
| Microsoft.NetCore.Component.Runtime.3.1                                   | 16.7.30406.193 |
| Microsoft.NetCore.Component.SDK                                           | 16.7.30406.193 |
| Microsoft.NetCore.Component.Web                                           | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.Azure.Kubernetes.Tools                   | 16.7.30310.162 |
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
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.DockerTools                              | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 16.7.30322.227 |
| Microsoft.VisualStudio.Component.DslTools                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp                                   | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Graphics                                 | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.IISExpress                               | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 0.2            |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 16.1.28811.260 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 16.4.29318.151 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.Merq                                     | 16.2.29012.281 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 16.0.28707.177 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.NuGet                                    | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 16.0.28714.129 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 16.7.30310.162 |
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
| Microsoft.VisualStudio.Component.TypeScript.3.9                           | 16.0.30322.227 |
| Microsoft.VisualStudio.Component.Unity                                    | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.VC.14.25.x86.x64                         | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.140                                   | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 16.3.29103.31  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 16.3.29207.166 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 16.4.29313.120 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM.Spectre                  | 16.5.29721.120 |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM64.Spectre                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM.Spectre                  | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM64.Spectre                | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 16.5.29515.121 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 16.0.28315.86  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 16.0.28625.61  |
| Microsoft.VisualStudio.Component.Web                                      | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 16.4.29409.204 |
| Microsoft.VisualStudio.Component.Windows10SDK.16299                       | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.Windows10SDK.17134                       | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.Windows10SDK.17763                       | 16.0.28517.75  |
| Microsoft.VisualStudio.Component.Windows10SDK.18362                       | 16.1.28829.92  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 16.7.30310.162 |
| Microsoft.VisualStudio.Component.WinXP                                    | 16.1.28811.260 |
| Microsoft.VisualStudio.Component.Workflow                                 | 16.0.28315.86  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 16.0.28621.142 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 16.4.29409.204 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 16.7.30310.162 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 16.0.28528.71  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 16.0.28621.142 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 16.7.30310.162 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 16.2.29012.281 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 16.7.30310.162 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 16.3.29102.218 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 16.4.29409.204 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 16.5.29514.35  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 16.4.29318.151 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 16.4.29318.151 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 16.2.29003.222 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 16.7.30310.162 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 16.3.29207.166 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 16.0.28315.86  |
| Microsoft.VisualStudio.Workload.Azure                                     | 16.4.29409.204 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 16.0.28315.86  |
| Microsoft.VisualStudio.Workload.Data                                      | 16.0.28720.110 |
| Microsoft.VisualStudio.Workload.DataScience                               | 16.0.28720.110 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 16.7.30310.162 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 16.4.29409.204 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NetCoreTools                              | 16.7.30310.162 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 16.5.29514.35  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 16.4.29409.204 |
| Microsoft.VisualStudio.Workload.Node                                      | 16.1.28825.262 |
| Microsoft.VisualStudio.Workload.Office                                    | 16.3.29207.166 |
| Microsoft.VisualStudio.Workload.Python                                    | 16.0.28621.142 |
| Microsoft.VisualStudio.Workload.Universal                                 | 16.7.30310.162 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 16.4.29409.204 |
| SSDT Microsoft Analysis Services Projects                                 | 2.9.12         |
| SSDT SQL Server Integration Services Projects                             | 3.9            |
| SSDT Microsoft Reporting Services Projects                                | 2.6.7          |
| Windows Driver Kit                                                        | 3.11.4516      |
| Windows Driver Kit Visual Studio Extension                                | 10.1.19041.1   |
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
| Microsoft Visual C++ 2019 Additional Runtime | x64          | 14.27.29016 |
| Microsoft Visual C++ 2019 Debug Runtime      | x64          | 14.27.29016 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x64          | 14.27.29016 |
| Microsoft Visual C++ 2019 Additional Runtime | x86          | 14.27.29016 |
| Microsoft Visual C++ 2019 Debug Runtime      | x86          | 14.27.29016 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x86          | 14.27.29016 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.0.3

#### Azure Powershell Modules
| Module  | Version                                                                       | Path                           |
| ------- | ----------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0<br>1.6.0<br>2.3.2<br>2.6.0<br>3.1.0<br>3.5.0<br>3.8.0<br>4.3.0<br>4.4.0 | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>5.3.0                         | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>6.7.0<br>6.13.1               | C:\Modules\azurerm_\<version\> |
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
#### Powershell Modules
| Module             | Version            |
| ------------------ | ------------------ |
| DockerMsftProvider | 1.0.0.8            |
| MarkdownPS         | 1.9                |
| Pester             | 3.4.0<br>5.0.3     |
| PowerShellGet      | 1.0.0.1<br>2.2.4.1 |
| PSWindowsUpdate    | 2.2.0.2            |
| SqlServer          | 21.1.18226         |
| VSSetup            | 2.2.16             |

### Android SDK Tools
| Package Name   | Description                                 |
| -------------- | ------------------------------------------- |
| platform-tools | Android SDK Platform-Tools, Revision 30.0.4 |
| tools          | Android SDK Tools 26.1.1, Revision 26.1.1   |

### Android SDK Platforms
`Location C:\Program Files (x86)\Android\android-sdk\platforms`
| Package Name | Description                                |
| ------------ | ------------------------------------------ |
| android-19   | Android SDK Platform 19, Revision 4        |
| android-21   | Android SDK Platform 21, Revision 2        |
| android-22   | Android SDK Platform 22, Revision 2        |
| android-23   | Android SDK Platform 23, Revision 3        |
| android-24   | Android SDK Platform 24, Revision 2        |
| android-25   | Android SDK Platform 25, Revision 3        |
| android-26   | Android SDK Platform 26, Revision 2        |
| android-27   | Android SDK Platform 27, Revision 3        |
| android-28   | Android SDK Platform 28, rev 6, Revision 6 |
| android-29   | Android SDK Platform 29, Revision 5        |
| android-30   | Android SDK Platform 30, Revision 3        |

### Android SDK Build-Tools
`Location C:\Program Files (x86)\Android\android-sdk\build-tools`
| Package Name       | Description                              |
| ------------------ | ---------------------------------------- |
| build-tools-19.1.0 | Android SDK Build-Tools, Revision 19.1.0 |
| build-tools-20.0.0 | Android SDK Build-Tools, Revision 20.0.0 |
| build-tools-21.1.2 | Android SDK Build-Tools, Revision 21.1.2 |
| build-tools-22.0.1 | Android SDK Build-Tools, Revision 22.0.1 |
| build-tools-23.0.1 | Android SDK Build-Tools, Revision 23.0.1 |
| build-tools-23.0.2 | Android SDK Build-Tools, Revision 23.0.2 |
| build-tools-23.0.3 | Android SDK Build-Tools, Revision 23.0.3 |
| build-tools-24.0.0 | Android SDK Build-Tools, Revision 24.0.0 |
| build-tools-24.0.1 | Android SDK Build-Tools, Revision 24.0.1 |
| build-tools-24.0.2 | Android SDK Build-Tools, Revision 24.0.2 |
| build-tools-24.0.3 | Android SDK Build-Tools, Revision 24.0.3 |
| build-tools-25.0.0 | Android SDK Build-Tools, Revision 25.0.0 |
| build-tools-25.0.1 | Android SDK Build-Tools, Revision 25.0.1 |
| build-tools-25.0.2 | Android SDK Build-Tools, Revision 25.0.2 |
| build-tools-25.0.3 | Android SDK Build-Tools, Revision 25.0.3 |
| build-tools-26.0.0 | Android SDK Build-Tools, Revision 26.0.0 |
| build-tools-26.0.1 | Android SDK Build-Tools, Revision 26.0.1 |
| build-tools-26.0.2 | Android SDK Build-Tools, Revision 26.0.2 |
| build-tools-26.0.3 | Android SDK Build-Tools, Revision 26.0.3 |
| build-tools-27.0.0 | Android SDK Build-Tools, Revision 27.0.0 |
| build-tools-27.0.1 | Android SDK Build-Tools, Revision 27.0.1 |
| build-tools-27.0.2 | Android SDK Build-Tools, Revision 27.0.2 |
| build-tools-27.0.3 | Android SDK Build-Tools, Revision 27.0.3 |
| build-tools-28.0.0 | Android SDK Build-Tools, Revision 28.0.0 |
| build-tools-28.0.1 | Android SDK Build-Tools, Revision 28.0.1 |
| build-tools-28.0.2 | Android SDK Build-Tools, Revision 28.0.2 |
| build-tools-28.0.3 | Android SDK Build-Tools, Revision 28.0.3 |
| build-tools-29.0.0 | Android SDK Build-Tools, Revision 29.0.0 |
| build-tools-29.0.1 | Android SDK Build-Tools, Revision 29.0.1 |
| build-tools-29.0.2 | Android SDK Build-Tools, Revision 29.0.2 |
| build-tools-29.0.3 | Android SDK Build-Tools, Revision 29.0.3 |
| build-tools-30.0.0 | Android SDK Build-Tools, Revision 30.0.0 |
| build-tools-30.0.1 | Android SDK Build-Tools, Revision 30.0.1 |
| build-tools-30.0.2 | Android SDK Build-Tools, Revision 30.0.2 |

### Android Extra Packages
| Package Name               | Version      |
| -------------------------- | ------------ |
| Android Support Repository | 47.0.0       |
| Google Play services       | 49           |
| Google Repository          | 58           |
| NDK                        | 21.3.6528147 |

### Cached Docker images
-  mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
-  mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019
-  mcr.microsoft.com/windows/servercore:ltsc2019
-  mcr.microsoft.com/windows/nanoserver:1809
-  microsoft/aspnetcore-build:1.0-2.0


