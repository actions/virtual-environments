#!/bin/bash -e
################################################################################
##  File:  gcc.sh
##  Desc:  Installs GNU C++
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

function InstallGcc {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    if ! command -v $version; then
        echo "$version was not installed"
        exit 1
    fi
}

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=(
    "g++-7"
    "g++-8"
    "g++-9"
)

if ! isUbuntu16; then
    versions+=("g++-10")
fi

for version in ${versions[*]}; do
    InstallGcc $version
done
