| Announcements |
|-|
| [[Ubuntu] Ansible will be updated to Ansible 4 on July, 19th](https://github.com/actions/virtual-environments/issues/3714) |
| [Ubuntu 16.04 environment will be removed on September 20, 2021](https://github.com/actions/virtual-environments/issues/3287) |
| [[all OS] MongoDB will be updated to version 5 on July, 26th](https://github.com/actions/virtual-environments/issues/3749) |
***
# Ubuntu 18.04.5 LTS
- Linux kernel version: 5.4.0-1051-azure
- Image Version: 20210718.1

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Erlang 24.0.2 (Eshell 12.0.2)
- Erlang rebar3 3.16.1
- GNU C++ 7.5.0, 9.4.0, 10.3.0
- GNU Fortran 7.5.0, 9.4.0, 10.3.0
- Julia 1.6.2
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-bionic main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.17.3
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.4.2

### Package Management
- cpan 1.64
- Helm 3.6.3
- Homebrew 3.2.2
- Miniconda 4.9.2
- Npm 6.14.13
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 0.16.3
- RubyGems 2.7.6
- Vcpkg  (build from master \<111220b>)
- Yarn 1.22.10

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.5
- Gradle 7.1.1
- Maven 3.8.1
- Sbt 1.5.5

### Tools
- Ansible 2.11.2
- apt-fast 1.9.11
- AzCopy 10.11.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.1.0
- Bazelisk 1.10.1
- Bicep 0.4.412
- Buildah 1.19.6 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.21.0
- CodeQL Action Bundle 2.5.7
- Docker Compose 1.29.2
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.7+azure
- Docker-Moby Server 20.10.7+azure
- Git 2.32.0 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.56.1
- HHVM (HipHop VM) 4.118.1
- jq 1.5
- Kind 0.11.1
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.2.0
- Leiningen 2.9.6
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.22.0
- Newman 5.2.4
- nvm 0.38.0
- OpenSSL 1.1.1  11 Sep 2018
- Packer 1.7.3
- PhantomJS 2.1.1
- Podman 3.0.1 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.7.0
- R 4.1.0
- Skopeo 1.2.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.0.2
- yamllint 1.26.1
- yq 4.11.0
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.81
- AWS CLI 1.20.1
- AWS CLI Session manager plugin 1.2.205.0
- AWS SAM CLI 1.26.0
- Azure CLI (azure-cli) 2.26.1 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.12.1
- Google Cloud SDK 348.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 4.4.2
- OpenShift CLI 4.7.19
- ORAS CLI 0.12.0
- Vercel CLI 23.0.1

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.292+1 (default) | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.11+9           | Adopt OpenJDK | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK | JAVA_HOME_12_X64     |

### PHP
| Tool     | Version                           |
| -------- | --------------------------------- |
| PHP      | 7.1.33 7.2.34 7.3.29 7.4.21 8.0.8 |
| Composer | 2.1.3                             |
| PHPUnit  | 8.5.17                            |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.4.0.0
- GHC 9.0.1 (apt source repository: ppa:hvr/ghc)
- GHCup 0.1.15.2
- Stack 2.7.1

### Rust Tools
- Cargo 1.53.0
- Rust 1.53.0
- Rustdoc 1.53.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.58.1
- Cargo audit 0.15.0
- Cargo clippy 0.1.53
- Cargo outdated 0.9.17
- Cbindgen 0.19.0
- Rustfmt 1.4.37

### Browsers and Drivers
- Google Chrome 91.0.4472.164
- ChromeDriver 91.0.4472.101
- Mozilla Firefox 90.0
- Geckodriver 0.29.1
- Chromium 91.0.4472.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.302 2.1.403 2.1.524 2.1.617 2.1.701 2.1.816 3.1.117 3.1.202 3.1.302 3.1.411 5.0.104 5.0.205 5.0.302

### Databases
- MongoDB 4.4.7 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- Postgre SQL 13.3 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- sqlite3 3.22.0

#### MySQL
- MySQL 5.7.34
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.7.0001.1
- SqlPackage 15.0.5084.2

### Cached Tools
#### Go
- 1.13.15
- 1.14.15
- 1.15.14

#### Node.js
- 10.24.1
- 12.22.3
- 14.17.3

#### PyPy
- 2.7.18 [PyPy 7.3.5]
- 3.6.12 [PyPy 7.3.3]

#### Python
- 2.7.18
- 3.5.10
- 3.6.14
- 3.7.11
- 3.8.11
- 3.9.6

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.8
- 2.7.4
- 3.0.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_13_X64 | /opt/hostedtoolcache/go/1.13.15/x64 | x64          |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.14/x64 | x64          |

### PowerShell Tools
- PowerShell 7.1.3

#### PowerShell Modules
| Module     | Version |
| ---------- | ------- |
| MarkdownPS | 1.9     |
| Pester     | 5.2.2   |

#### Az PowerShell Modules
- 6.1.0 3.1.0.zip 4.4.0.zip 5.9.0.zip

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                 |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                                     |
| Android Emulator           | 30.7.5                                                                                                                                                                                                                                                  |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 31.0.2                                                                                                                                                                                                                                                  |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                                      |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                  |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                  |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                        |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                |
| Google Play services       | 49                                                                                                                                                                                                                                                      |
| Google Repository          | 58                                                                                                                                                                                                                                                      |
| NDK                        | 21.4.7075529                                                                                                                                                                                                                                            |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                       |

#### Environment variables
| Name             | Value                                                                                |
| ---------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME     | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_ROOT | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag         | Digest                                                                   | Created    |
| ---------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.11            | sha256:20117524da64d995fd769f0aa3d7cfe2040518426f4b238f43e8373f4aa56c06  | 2021-04-14 |
| alpine:3.12            | sha256:87703314048c40236c6d674424159ee862e2b96ce1c37c62d877e21ed27a387e  | 2021-04-14 |
| alpine:3.13            | sha256:f51ff2d96627690d62fee79e6eecd9fa87429a38142b5df8a3bfbb26061df7fc  | 2021-04-14 |
| buildpack-deps:buster  | sha256:128203abc1feabf1e0b2bef26a23860a7283770d25fcd3cf30277e1dda4909f1  | 2021-06-23 |
| buildpack-deps:stretch | sha256:04f933352c6a3e46933907f5a7fb6f37134e027207f5de2d3c234bfec43d0d72  | 2021-06-23 |
| debian:10              | sha256:dcb20da8d9d73c9dab5059668852555c171d40cdec297da845da9c929b70e0b1  | 2021-06-23 |
| debian:9               | sha256:8afcdd92f29e1706625631df94ecdfe3bdeb919bb2c6ee685803d245b75ee45a  | 2021-06-23 |
| node:10                | sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911  | 2021-04-10 |
| node:10-alpine         | sha256:dc98dac24efd4254f75976c40bce46944697a110d06ce7fa47e7268470cf2e28  | 2021-04-14 |
| node:12                | sha256:3f646f48001e2cd732a4c0291e1fa5bfcadaaafc3a41227a0bcc76c998c2cee6  | 2021-07-07 |
| node:12-alpine         | sha256:05328aa871f251b0643b8dcaa01034f126a8343b51ef302de207ad153a6b6232  | 2021-07-07 |
| node:14                | sha256:0c558991de47e614588a61f9cc90afdcf034c6fc641d3ab650c9570a98b37605  | 2021-07-07 |
| node:14-alpine         | sha256:fb6cb918cc72869bd625940f42a7d8ae035c4e786d08187b94e8b91c6a534dfd  | 2021-07-07 |
| ubuntu:16.04           | sha256:1b733ff6c7c7aac32101a35cb2c6399ca8c399a9f6de62a386abe26c65b59b9e  | 2021-06-17 |
| ubuntu:18.04           | sha256:3b8692dc4474d4f6043fae285676699361792ce1828e22b1b57367b5c05457e3  | 2021-07-13 |
| ubuntu:20.04           | sha256:b3e2e47d016c08b3396b5ebe06ab0b711c34e7f37b98c9d37abe794b71cea0a2  | 2021-07-13 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| binutils          | 2.30-21ubuntu1~18.04.5            |
| bison             | 2:3.0.4.dfsg-1build1              |
| brotli            | 1.0.3-1ubuntu1.3                  |
| build-essential   | 12.4ubuntu1                       |
| bzip2             | 1.0.6-8.1ubuntu0.2                |
| coreutils         | 8.28-1ubuntu1                     |
| curl              | 7.58.0-2ubuntu3.13                |
| dbus              | 1.12.2-1ubuntu1.2                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.15         |
| dpkg              | 1.19.0.5ubuntu2.3                 |
| fakeroot          | 1.22-2ubuntu1                     |
| file              | 1:5.32-2ubuntu0.4                 |
| flex              | 2.6.4-6                           |
| ftp               | 0.17-34                           |
| gnupg2            | 2.2.4-1ubuntu1.4                  |
| haveged           | 1.9.1-6                           |
| imagemagick       | 8:6.9.7.4+dfsg-16ubuntu6.11       |
| iproute2          | 4.15.0-2ubuntu1.3                 |
| iputils-ping      | 3:20161105-1ubuntu3               |
| jq                | 1.5+dfsg-2                        |
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2            |
| libc++-dev        | 6.0-2                             |
| libc++abi-dev     | 6.0-2                             |
| libcurl3          | 7.58.0-2ubuntu3.13                |
| libgbm-dev        | 20.0.8-0ubuntu1~18.04.1           |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.11       |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.11       |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.4                 |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| locales           | 2.27-3ubuntu1.4                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.3                |
| p7zip-full        | 16.02+dfsg-6                      |
| p7zip-rar         | 16.02-2                           |
| parallel          | 20161222-1                        |
| pass              | 1.7.1-3                           |
| patchelf          | 0.9-1                             |
| pkg-config        | 0.29.1-0ubuntu2                   |
| pollinate         | 4.33-0ubuntu1~18.04.2             |
| python-setuptools | 39.0.1-2                          |
| rpm               | 4.14.1+dfsg1-2                    |
| rsync             | 3.1.2-2.1ubuntu1.1                |
| shellcheck        | 0.4.6-1                           |
| sphinxsearch      | 2.2.11-2                          |
| sqlite3           | 3.22.0-1ubuntu0.4                 |
| ssh               | 1:7.6p1-4ubuntu0.3                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1                    |
| sudo              | 1.8.21p2-3ubuntu1.4               |
| swig              | 3.0.12-1                          |
| telnet            | 0.17-41                           |
| texinfo           | 6.5.0.dfsg.1-2                    |
| time              | 1.7-25.1build1                    |
| tk                | 8.6.0+9                           |
| tzdata            | 2021a-0ubuntu0.18.04              |
| unzip             | 6.0-21ubuntu1.1                   |
| upx               | 3.94-4                            |
| wget              | 1.19.4-1ubuntu2.2                 |
| xorriso           | 1.4.8-3                           |
| xvfb              | 2:1.19.6-1ubuntu4.9               |
| xz-utils          | 5.2.2-1.3                         |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |


