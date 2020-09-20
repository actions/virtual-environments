#!/bin/bash
################################################################################
##  File:  pollinate.sh
##  Desc:  Installs Pollinate
################################################################################


# Install Pollinate
apt-get install -y --no-install-recommends pollinate

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v pollinate; then
    echo "pollinate was not installed"
    exit 1
fi
