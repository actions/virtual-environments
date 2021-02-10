#!/bin/bash -e
################################################################################
##  File:  ansible.sh
##  Desc:  Installs Ansible
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

# ppa:ansible/ansible doesn't contain packages for Ubuntu20.04
if isUbuntu16 || isUbuntu18 ; then
    add-apt-repository ppa:ansible/ansible
    apt-get update
fi

# Install latest Ansible
apt-get install -y --no-install-recommends ansible

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v ansible; then
    echo "Ansible was not installed or found on PATH"
    exit 1
fi
