#!/bin/bash
################################################################################
##  File:  packer.sh
##  Desc:  Installs packer
################################################################################


# Install Packer
PACKER_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/packer | jq -r .current_version)
curl -LO "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
unzip "packer_${PACKER_VERSION}_linux_amd64.zip" -d /usr/local/bin
rm -f "packer_${PACKER_VERSION}_linux_amd64.zip"

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v packer; then
    echo "Packer was not installed or found on PATH"
    exit 1
fi
