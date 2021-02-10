#!/bin/sh
echo "Installing Cocoapods..."

# Setup the Cocoapods master repo
echo Setting up the Cocoapods master repository...
pod setup

# Create a symlink to /usr/local/bin since it was removed due to Homebrew change.
ln -sf $(which pod) /usr/local/bin/pod