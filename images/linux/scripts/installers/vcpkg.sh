#!/bin/bash
################################################################################
##  File:  vcpkg.sh
##  Desc:  Installs vcpkg
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone --depth=1 https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT

# vcpkg requires g++ version 7+, yet Ubuntu 16 default is 5.4. Set version 7 as default temporarily
if isUbuntu16; then
    ln -sf g++-7 /usr/bin/g++
fi

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

# Set back g++ 5.4 as default
if isUbuntu16; then
    ln -sf g++-5 /usr/bin/g++
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v vcpkg; then
    echo "vcpkg was not installed"
    exit 1
fi
