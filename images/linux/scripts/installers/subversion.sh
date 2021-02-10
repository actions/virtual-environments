#!/bin/bash -e
################################################################################
##  File:  subversion.sh
##  Desc:  Installs Subversion client
################################################################################

# Install Subversion
apt-get install -y --no-install-recommends subversion

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v svn; then
    echo "Subversion (svn) was not installed"
    exit 1
fi
