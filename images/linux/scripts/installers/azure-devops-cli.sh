#!/bin/bash -e
################################################################################
##  File:  azure-devops-cli.sh
##  Desc:  Installed Azure DevOps CLI (az devops)
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
echo "AZURE_EXTENSION_DIR=$AZURE_EXTENSION_DIR" | tee -a /etc/environment

# install azure devops Cli extension
az extension add -n azure-devops

echo "Testing to make sure that script performed as expected, and basic scenarios work"
invoke_tests "CLI.Tools" "Azure DevOps CLI"