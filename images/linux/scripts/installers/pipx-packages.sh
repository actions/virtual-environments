#!/bin/bash
################################################################################
##  File:  pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################


export PATH="$PATH:/opt/pipx_bin"

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
pipx_packages=$(jq -r ".pipx[] .package" $toolset)

for package in $pipx_packages; do
    python_version=$(jq -r ".pipx[] | select(.package == \"$package\") .python" $toolset)
    if [ "$python_version" != "null" ]; then
        python_path="/opt/hostedtoolcache/Python/$python_version*/x64/bin/python$python_version"
        echo "Install $package into python $python_path"
        pipx install $package --python $python_path
    else
        echo "Install $package into default python"
        pipx install $package
    fi

    # Run tests to determine that the software installed as expected
    cmd=$(jq -r ".pipx[] | select(.package == \"$package\") .cmd" $toolset)
    if ! command -v $cmd; then
        echo "$package was not installed"
        exit 1
    fi
done
