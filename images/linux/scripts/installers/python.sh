#!/bin/bash
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

# Install Python, Python 3, pip, pip3
if isUbuntu20 ; then
    apt-get install -y --no-install-recommends python3 python3-dev python3-pip

    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    python2 get-pip.py
fi

if isUbuntu16 || isUbuntu18 ; then
    apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in python pip python3 pip3; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done
