| Announcements |
|-|
| [[Ubuntu] AzCopy 7 will be removed from Ubuntu images on March, 2](https://github.com/actions/virtual-environments/issues/2724) |
| [[ubuntu, windows] GOROOT environment variable will be removed on March, 1](https://github.com/actions/virtual-environments/issues/2683) |
| [[Ubuntu] Android SDK Platforms and Build-tools that are less than version 23 will be removed on March, 1](https://github.com/actions/virtual-environments/issues/2673) |
| [[Windows, Ubuntu] Boost 1.72.0 will be removed from images on March, 8](https://github.com/actions/virtual-environments/issues/2667) |
| [[Ubuntu, macOS] .NET 3.0 will be removed from images on March, 1](https://github.com/actions/virtual-environments/issues/2558) |
| [Ubuntu-latest workflows will use Ubuntu-20.04](https://github.com/actions/virtual-environments/issues/1816) |
***
# Ubuntu 20.04.2 LTS
- Image Version: 20210309.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 8.0.1, 9.0.1, 10.0.0
- Erlang 11.1.7
- GNU C++ 7.5.0, 8.4.0, 9.3.0, 10.2.0
- GNU Fortran 8.4.0, 9.3.0, 10.2.0
- Julia 1.5.3
- Mono 6.12.0.122
- Node 14.16.0
- Perl 5.30.0
- Python 3.8.5
- Python3 3.8.5
- Ruby 2.7.0p0
- Swift 5.3.3

### Package Management
- cpan 1.64
- Helm 3.5.2
- Homebrew 3.0.4
- Miniconda 4.9.2
- Npm 6.14.11
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 0.16.1.0
- RubyGems 3.1.2
- Vcpkg  (build from master \<0dc27b9>)
- Yarn 1.22.5

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 6.8.3
- Maven 3.6.3
- Sbt 1.4.7

### Tools
- 7-Zip 16.02
- Ansible 2.9.6
- apt-fast 1.9.10
- AzCopy 10.9.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.0.0
- Bazelisk 1.7.5
- binutils 2.34
- Buildah 1.19.6
- CMake 3.19.6
- CodeQL Action Bundle 2.4.4
- coreutils 8.30
- curl 7.68.0
- Docker Compose 1.28.5
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.5+azure
- Docker-Moby Server 20.10.5+azure
- Fastlane 2.177.0
- Git 2.30.1
- Git LFS 2.13.2
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.50.0
- HHVM (HipHop VM) 4.99.0
- jq 1.6
- Kind 0.10.0
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.0.5
- Leiningen 2.9.5
- m4 1.4.18
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.18.1
- net-tools 1.60
- Newman 5.2.2
- nvm 0.37.2
- Packer 1.7.0
- pass 1.7.3
- PhantomJS 2.1.1
- Podman 3.0.1
- Pulumi 2.22.0
- R 4.0.4
- Skopeo 1.2.2
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Swig 4.0.1
- Terraform 0.14.7
- unzip 6.00
- wget 1.20.3
- yamllint 1.26.0
- zip 3.0
- zstd 1.4.4

### CLI Tools
- Alibaba Cloud CLI 3.0.73
- AWS CLI 2.1.29
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.20.0
- Azure CLI (azure-cli) 2.20.0
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.7.0
- Google Cloud SDK 330.0.0
- Hub CLI 2.14.2
- Netlify CLI 3.10.6
- oc CLI 4.7.0
- ORAS CLI 0.10.0
- Vercel CLI 21.3.3

### Java
| Version           | Vendor       | Environment Variable |
| ----------------- | ------------ | -------------------- |
| 1.8.0_282         | AdoptOpenJDK | JAVA_HOME_8_X64      |
| 11.0.10 (default) | AdoptOpenJDK | JAVA_HOME_11_X64     |

### GraalVM
| Version     | Environment variables |
| ----------- | --------------------- |
| CE 21.0.0.2 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version      |
| -------- | ------------ |
| PHP      | 7.4.16 8.0.3 |
| Composer | 2.0.11       |
| PHPUnit  | 8.5.14       |

### Haskell
- Cabal 3.4.0.0
- GHC 9.0.1
- GHCup 0.1.14
- Stack 2.5.1

### Rust Tools
- Cargo 1.50.0
- Rust 1.50.0
- Rustdoc 1.50.0
- Rustup 1.23.1

#### Packages
- Bindgen 0.57.0
- Cargo audit 0.14.0
- Cargo clippy 0.0.212
- Cargo outdated 0.9.14
- Cbindgen 0.18.0
- Rustfmt 1.4.30

### Browsers and Drivers
- Chromium 89.0.4389.82
- Google Chrome 89.0.4389.82
- ChromeDriver 89.0.4389.23
- Mozilla Firefox 86.0
- Geckodriver 0.29.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.521 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 2.1.813 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.112 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 3.1.406 5.0.100 5.0.101 5.0.102 5.0.103 5.0.200

### Az Module
- 3.8.0 4.8.0

### Databases
- MongoDB 4.4.4
- Postgre SQL 13.2
- sqlite3 3.31.1

#### MySQL
- MySQL 8.0.23
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.7.0001.1

### Cached Tools
#### Go
- 1.14.15
- 1.15.8
- 1.16.0

#### Node.js
- 10.24.0
- 12.21.0
- 14.16.0

#### PyPy
- 2.7.18 [PyPy 7.3.3]
- 3.6.12 [PyPy 7.3.3]
- 3.7.9 [PyPy 7.3.3-beta0]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.8
- 3.9.2

#### Ruby
- 2.5.8
- 2.6.6
- 2.7.2
- 3.0.0

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.8/x64  | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.0/x64  | x64          |

### PowerShell Tools
- PowerShell 7.1.2

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Pester           | 5.1.1   |
| PSScriptAnalyzer | 1.19.1  |

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                  |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 3.0                                                                                                                      |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 31.0.0                                                                                                                   |
| Android SDK Platforms      | android-S (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                |
| Android SDK Tools          | 26.1.1                                                                                                                   |
| Android Support Repository | 47.0.0                                                                                                                   |
| CMake                      | 3.10.2                                                                                                                   |
| Google Play services       | 49                                                                                                                       |
| Google Repository          | 58                                                                                                                       |
| NDK                        | 21.4.7075529<br>22.0.7026061                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                        |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/22.0.7026061                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag                                            | Digest                                                                   | Created    |
| --------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.10                                               | sha256:0b4d282d7ae7cf5ed91801654a918aea45d6c1de6df0db6a29d60619141fb8de  | 2021-02-24 |
| alpine:3.7                                                | sha256:8421d9a84432575381bfabd248f1eb56f3aa21d9d7cd2511583c68c9b7511d10  | 2019-03-07 |
| alpine:3.8                                                | sha256:2bb501e6173d9d006e56de5bce2720eb06396803300fe1687b58a7ff32bf4c14  | 2020-01-23 |
| alpine:3.9                                                | sha256:414e0518bb9228d35e4cd5165567fb91d26c6a214e9c95899e1e056fcd349011  | 2020-04-24 |
| buildpack-deps:buster                                     | sha256:b42568b32a4dff4f1f378fd0685aa2a8e6931e744798a481fd6ed6672d7f0c47  | 2021-02-09 |
| buildpack-deps:stretch                                    | sha256:97f102be9829fa96039a6113e0f053ffdadf2b2ccb67e8838294aee8a2dd947f  | 2021-02-09 |
| debian:8                                                  | sha256:40d6faa8c33e8ab03428ad97fc109c369fb510d99f4700df9058940ac9944f09  | 2021-02-09 |
| debian:9                                                  | sha256:d0b7b71db141cedc48e1c2807d12b199ffd7ffe75baf272a34c37480dc2159d1  | 2021-02-09 |
| jekyll/builder:latest                                     | sha256:b918b81939a1076dce89d142c0764c2c3cb93858f56ecf4f04ad0387338e77aa  | 2020-12-21 |
| mcr.microsoft.com/azure-pipelines/node8-typescript:latest | sha256:e52e60b9f71183969830a3664279b5d8c799b4b0ec2c25a0686f7c02f6a9669a  | 2018-10-09 |
| node:10                                                   | sha256:426ce4b7e659e081413b739ec3c6a6dea22dfc1a53bfaa147117dfb0238013a2  | 2021-02-23 |
| node:10-alpine                                            | sha256:47cfff9b9eda43e97f42d516ff66c5490ed1f71262a03f3348ea867f222c1a7e  | 2021-02-24 |
| node:12                                                   | sha256:7f961434ce9e96be7bf2455bbf362152787c529bb9cf86a15ab1499ea89bfa8c  | 2021-02-23 |
| node:12-alpine                                            | sha256:5d8b181a0738654bbe659a68879298f8d2d4256685282ee1c2330d97c33e3eee  | 2021-02-24 |
| ubuntu:14.04                                              | sha256:63fce984528cec8714c365919882f8fb64c8a3edf23fdfa0b218a2756125456f  | 2020-09-16 |

### Installed apt packages
- binutils, bison, brotli, build-essential, bzip2, chromium-browser, coreutils, curl, dbus, dnsutils, dpkg, fakeroot, file, flex, ftp, gnupg2, haveged, imagemagick, iproute2, iputils-ping, jq, lib32z1, libc++-dev, libc++abi-dev, libcurl4, libgbm-dev, libgconf-2-4, libgsl-dev, libgtk-3-0, libmagic-dev, libmagickcore-dev, libmagickwand-dev, libsecret-1-dev, libsqlite3-dev, libunwind8, libxkbfile-dev, libxss1, locales, m4, mediainfo, net-tools, netcat, openssh-client, p7zip-full, p7zip-rar, parallel, pass, patchelf, pkg-config, pollinate, python-is-python3, rpm, rsync, shellcheck, sphinxsearch, sqlite3, ssh, subversion, sudo, swig, telnet, texinfo, time, tk, tzdata, unzip, upx, wget, xorriso, xvfb, xz-utils, zip, zstd, zsync



