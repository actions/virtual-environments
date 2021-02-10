#!/bin/bash -e
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

set -e
# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

# Install Python, Python 3, pip, pip3
if isUbuntu16 || isUbuntu18; then
    apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip python3-venv
fi

if isUbuntu20; then
    apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv
    ln -s /usr/bin/pip3 /usr/bin/pip
fi

if isUbuntu18 || isUbuntu20 ; then
    # Install pipx
    # Set pipx custom directory
    export PIPX_BIN_DIR=/opt/pipx_bin
    export PIPX_HOME=/opt/pipx

    python3 -m pip install pipx
    python3 -m pipx ensurepath

    # Update /etc/environment
    setEtcEnvironmentVariable "PIPX_BIN_DIR" $PIPX_BIN_DIR
    setEtcEnvironmentVariable "PIPX_HOME" $PIPX_HOME
    prependEtcEnvironmentPath $PIPX_BIN_DIR

    # Test pipx
    if ! command -v pipx; then
        echo "pipx was not installed or not found on PATH"
        exit 1
    fi
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in python pip python3 pip3; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done
