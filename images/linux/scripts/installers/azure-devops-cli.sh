#!/bin/bash -e
################################################################################
##  File:  azure-devops-cli.sh
##  Desc:  Installed Azure DevOps CLI (az devops)
################################################################################

# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
echo "AZURE_EXTENSION_DIR=$AZURE_EXTENSION_DIR" | tee -a /etc/environment

# install azure devops Cli extension
az extension add -n azure-devops

# check to determine if extension was installed or not
if [ $? -eq 0 ]
then
    echo "azure DevOps Cli extension was installed"
else
    echo "azure DevOps Cli extension was not installed"
    exit 1
fi
