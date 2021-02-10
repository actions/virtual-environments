#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

# Install Heroku CLI
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v heroku; then
    exit 1
fi
