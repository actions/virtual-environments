#!/bin/bash
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################


# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v 7z; then
    echo "7-Zip was not installed"
    exit 1
fi
