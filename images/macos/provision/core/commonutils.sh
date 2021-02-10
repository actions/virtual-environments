#!/bin/sh
set -e

source ~/utils/utils.sh

# TO-DO: Move the list of brew packages and casks to toolset

# brew install
binst_common_utils=(
    carthage
    cmake
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
    gh
    p7zip
    ant
    yamllint
    aria2
)

if is_Less_BigSur; then
    binst_common_utils+=(
        xctool
        bats
        parallel
    )
fi

for package in ${binst_common_utils[@]}; do
    echo "Install $package"
    brew install $package
done

# brew cask install
bcask_common_utils=(
    julia
)

if is_Less_BigSur; then
    bcask_common_utils+=(
        virtualbox
        vagrant
        r
    )
fi

for package in ${bcask_common_utils[@]}; do
    echo "Install $package"
    brew cask install $package
done

if ! is_HighSierra; then
    brew install swiftlint
fi

# Invoke bazel to download the latest bazel version via bazelisk
bazel
