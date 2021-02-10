#!/bin/bash -e
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
common_packages=$(jq -r ".apt.common_packages[]" $toolset)
cmd_packages=$(jq -r ".apt.cmd_packages[]" $toolset)
for package in $common_packages $cmd_packages; do
    echo "Install $package"
    apt-get install -y --no-install-recommends $package
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in $cmd_packages; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done
