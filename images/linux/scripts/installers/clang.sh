#!/bin/bash
################################################################################
##  File:  clang.sh
##  Desc:  Installs Clang compiler
################################################################################
set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

function InstallClang {
    local version=$1

    echo "Installing clang-$version..."
    if [[ $version =~ (9|10) ]]; then
        ./llvm.sh $version
        apt-get install -y "clang-format-$version"
    else
        apt-get install -y "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version"
    fi

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    for cmd in clang-$version clang++-$version; do
        if ! command -v $cmd; then
            echo "$cmd was not installed"
            exit 1
        fi
    done
}

function SetDefaultClang {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
}

# Download script for automatic installation
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh

if isUbuntu16 || isUbuntu18; then
   versions=( "6.0" "8" "9" )
   default_clang_version="9"
fi

if isUbuntu20 ; then
    versions=( "8" "9" "10" )
    default_clang_version="10"
fi

for version in ${versions[*]}; do
    InstallClang $version
done

SetDefaultClang $default_clang_version
rm llvm.sh
