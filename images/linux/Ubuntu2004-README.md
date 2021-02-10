| Announcements |
|-|
| [Default Python will be switched to 3.8 on Ubuntu 20.04 on October, 6](https://github.com/actions/virtual-environments/issues/1591) |
| [Clang/LLVM 10 will be set as a default one and Clang/LLVM 6 will be deprecated  for Ubuntu 20.04 on September, 23](https://github.com/actions/virtual-environments/issues/1536) |
***
# Ubuntu 20.04.1 LTS
- Image Version: 20201004.1

## Installed Software
### Language and Runtime
- GNU C++ 7.5.0, 8.4.0, 9.3.0, 10.0.1
- GNU Fortran 8.4.0, 9.3.0
- Clang 8.0.1, 9.0.1, 10.0.0
- Erlang 11.1
- Mono 6.12.0.90
- Node 12.18.4
- Python 3.8.2
- Python3 3.8.2
- PowerShell 7.0.3
- Ruby 2.7.0p0
- Swift 5.3
- Julia 1.5.2

### Package Management
- Homebrew 2.5.2
- Gem 3.1.2
- Miniconda 4.8.3
- Helm 3.3.4
- Npm 6.14.8
- Yarn 1.22.5
- Pip 20.0.2
- Pip3 20.0.2
- Vcpkg 2020.06.15

### Project Management
- Ant 1.10.7
- Gradle 6.6.1
- Maven 3.6.3
- Sbt 1.3.13

### Tools
- 7-Zip 16.02
- Ansible 2.9.6
- AzCopy10 10.6.0 (available by `azcopy10` alias)
- AzCopy7 7.3.0 (available by `azcopy` alias)
- Bazel 3.5.1
- Bazelisk 1.6.1
- Buildah 1.16.4
- CMake 3.17.0
- CodeQL Action Bundle 2.2.5
- curl 7.68.0
- Docker Compose 1.27.4
- Docker-Buildx 0.4.2
- Docker-Moby 19.03.13
- Git 2.28.0
- Git LFS 2.12.0
- Git-ftp 1.6.0
- Google Cloud SDK 312.0.0
- Haveged 1.9.1
- Heroku 7.44.0
- HHVM (HipHop VM) 4.77.0
- jq 1.6
- Kind 0.9.0
- Kubectl 1.19.2
- Kustomize 3.8.4
- Leiningen 2.9.4
- m4 1.4.18
- Mercurial 5.3.1
- Minikube 1.13.1
- Newman 5.2.0
- nvm 0.35.3
- Packer 1.6.4
- PhantomJS 2.1.1
- Podman 2.1.1
- Pulumi 2.11.2
- R 4.0.2
- Skopeo 1.2.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Swig 4.0.1
- Terraform 0.13.4
- unzip 6.00
- wget 1.20.3
- zip 3.0
- zstd 1.4.4

### CLI Tools
- Alibaba Cloud CLI 3.0.59
- AWS CLI 2.0.54
- AWS CLI Session manager plugin 1.1.61.0
- AWS SAM CLI 1.4.0
- Azure CLI (azure-cli) 2.12.1
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.0.0
- Hub CLI 2.14.2
- Netlify CLI 2.64.1
- oc CLI 4.5.0
- ORAS CLI 0.8.1
- Vercel CLI 20.1.1

### Java
| Version          | Vendor       | Environment Variable |
| ---------------- | ------------ | -------------------- |
| 1.8.0_265        | AdoptOpenJDK | JAVA_HOME_8_X64      |
| 11.0.8 (default) | AdoptOpenJDK | JAVA_HOME_11_X64     |

### PHP
| Tool     | Version |
| -------- | ------- |
| PHP      | 7.4.10  |
| Composer | 1.10.13 |
| PHPUnit  | 7.5.20  |

### Haskell
- GHC 8.10.2
- Cabal 3.4.0.0
- Stack 2.3.3

### Rust Tools
- Rust 1.46.0
- Rustup 1.22.1
- Rustdoc 1.46.0
- Cargo 1.46.0

#### Packages
- Bindgen 0.55.1
- Cargo audit 0.12.1
- Cargo outdated 0.9.11
- Cargo clippy 0.0.212
- Cbindgen 0.14.6
- Rustfmt 1.4.18

### Browsers and Drivers
- Google Chrome 85.0.4183.121
- ChromeDriver 85.0.4183.87
- Mozilla Firefox 81.0
- Geckodriver 0.27.0

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402

### Az Module
- 4.7.0

### Databases
- Postgre SQL 13.0
- MongoDB 4.4.1
- sqlite3 3.31.1

#### MySQL
- MySQL 8.0.21
- MySQL Server (user:root password:root)
- MS SQL Server Client Tools

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
### Cached Tools
#### Ruby
- 2.5.8
- 2.6.6
- 2.7.1

#### Python
- 2.7.18
- 3.5.10
- 3.6.12
- 3.7.9
- 3.8.6

#### PyPy
- 2.7.13 [PyPy 7.3.2]
- 3.6.9 [PyPy 7.3.2]

#### Node.js
- 8.17.0
- 10.22.1
- 12.18.4
- 14.13.0

#### Go
- 1.14.9
- 1.15.2

### Android
| Package Name               | Version                                                                                                    |
| -------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Android SDK Platform-Tools | 30.0.4                                                                                                     |
| Android SDK Tools          | 26.1.1                                                                                                     |
| Android SDK Platforms      | android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                       |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2<br>29.0.0 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| NDK                        | 21.3.6528147                                                                                               |
| Android Support Repository | 47.0.0                                                                                                     |
| Google Play services       | 49                                                                                                         |
| Google Repository          | 58                                                                                                         |
| SDK Patch Applier v4       | 1                                                                                                          |
| CMake                      | 3.10.2                                                                                                     |

### Cached Docker images
- alpine:3.7
- alpine:3.8
- alpine:3.9
- alpine:3.10
- buildpack-deps:stretch
- buildpack-deps:buster
- debian:8
- debian:9
- jekyll/builder
- mcr.microsoft.com/azure-pipelines/node8-typescript
- node:10
- node:12
- node:10-alpine
- node:12-alpine
- ubuntu:14.04

### Installed apt packages
- bison, brotli, bzip2, curl, dbus, dnsutils, dpkg, fakeroot, file, flex, ftp, gnupg2, iproute2, iputils-ping, jq, lib32z1, libc++-dev, libc++abi-dev, libcurl4, libgbm-dev, libgconf-2-4, libgtk-3-0, libsecret-1-dev, libsqlite3-dev, libunwind8, libxkbfile-dev, libxss1, locales, m4, netcat, openssh-client, parallel, patchelf, pkg-config, python-is-python3, rpm, rsync, shellcheck, sqlite3, ssh, sudo, telnet, texinfo, time, tk, tzdata, unzip, upx, wget, xorriso, xvfb, xz-utils, yamllint, zip, zstd, zsync


