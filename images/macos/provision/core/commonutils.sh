#!/bin/sh

set -e

source ~/utils/utils.sh
# brew install
binst_common_utils=(
    carthage
    xctool
    cmake
    bats
    parallel
    subversion
    go
    gnupg
    llvm
    libpq
    zstd
    packer
    helm
    aliyun-cli
    bazelisk
    github/gh/gh
    p7zip
    ant
    yamllint
    aria2
)

for package in ${binst_common_utils[@]}; do
    echo "Install $package"
    brew install $package
done

# brew cask install
bcask_common_utils=(
    julia
    virtualbox
    vagrant
    r
)

for package in ${bcask_common_utils[@]}; do
    echo "Install $package"
    brew cask install $package
done

if ! is_HighSierra; then
    brew install swiftlint
fi

# Invoke bazel to download the latest bazel version via bazelisk
bazel
