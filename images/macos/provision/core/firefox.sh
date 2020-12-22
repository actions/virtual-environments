#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

echo "Installing Firefox..."
brew install --cask firefox

echo "Installing Geckodriver..."
brew install geckodriver

echo "Add GECKOWEBDRIVER to bashrc..."
echo "export GECKOWEBDRIVER=$(brew --prefix geckodriver)/bin" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Firefox"