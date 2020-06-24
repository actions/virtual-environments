#!/bin/bash
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# Install the AWS CLI v1 on Ubuntu16 and Ubuntu18, and AWS CLI v2 on Ubuntu20
if isUbuntu20 ; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
    rm awscliv2.zip
    rm -rf aws
else
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    unzip awscli-bundle.zip
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
    rm awscli-bundle.zip
    rm -rf awscli-bundle
fi

# Validate the installation
echo "Validate the installation"
if ! command -v aws; then
    echo "aws was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "AWS CLI ($(aws --version 2>&1))"
