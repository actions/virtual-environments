#!/bin/bash -e
################################################################################
##  File:  netlify.sh
##  Desc:  Installs the Netlify CLI
################################################################################

# Install the Netlify CLI
npm i -g netlify-cli

# Validate the installation
echo "Validate the installation"
if ! command -v netlify; then
    echo "Netlify CLI was not installed"
    exit 1
fi
