#!/bin/bash -e
################################################################################
##  File:  build-essential.sh
##  Desc:  Installs build-essential package
################################################################################

source $HELPER_SCRIPTS/install.sh

PACKAGE=build-essential

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if ! IsPackageInstalled $PACKAGE; then
    echo "Installing $PACKAGE"
    apt-get install -y --no-install-recommends $PACKAGE
else
    echo "$PACKAGE is already installed"
fi
