#!/bin/bash
################################################################################
##  File:  hhvm.sh
##  Desc:  Installs hhvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

hhvm_package=hhvm

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if ! IsPackageInstalled ${hhvm_package}; then
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94
    add-apt-repository https://dl.hhvm.com/ubuntu
    apt-get update
    apt-get -qq install -y hhvm
else
    echo "${hhvm_package} already installed"
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! IsPackageInstalled ${hhvm_package}; then
    echo "${hhvm_package} was not installed"
    exit 1
fi

if ! command -v hhvm; then
    exit 1
fi
