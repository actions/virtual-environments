#!/bin/bash -e
################################################################################
##  File:  homebrew-validate.sh
##  Desc:  Validate the Homebrew can run after reboot without extra configuring
################################################################################

# Validate the installation
echo "Validate the Homebrew can run after reboot"

if ! command -v brew; then
    echo "brew executable not found after reboot"
    exit 1
fi

