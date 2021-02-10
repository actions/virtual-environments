#!/bin/bash -e
################################################################################
##  File:  rndgenerator.sh
##  Desc:  Install random number generator
################################################################################

# Install haveged
apt-get -y install haveged

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in haveged; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done
