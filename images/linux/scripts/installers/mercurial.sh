#!/bin/bash
################################################################################
##  File:  mercurial.sh
##  Desc:  Installs Mercurial
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

if isUbuntu16 ; then
    # Install Mercurial from the mercurial-ppa/releases repository for the latest version for Ubuntu16.
    # https://www.mercurial-scm.org/wiki/Download
    add-apt-repository ppa:mercurial-ppa/releases -y
    apt-get update
fi

apt-get install -y --no-install-recommends mercurial

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v hg; then
    exit 1
fi
