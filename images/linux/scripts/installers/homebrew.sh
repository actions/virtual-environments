#!/bin/bash
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs the Homebrew on Linux
##  Caveat: Brew MUST NOT be used to install any tool during the image build to avoid dependencies, which may come along with the tool
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/etc-environment.sh

# Install the Homebrew on Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Make brew files and directories writable by any user
sudo chmod -R o+w $HOMEBREW_PREFIX

# Update /etc/environemnt
## Put HOMEBREW_* variables
brew shellenv|grep 'export HOMEBREW'|sed -E 's/^export (.*);$/\1/' | sudo tee -a /etc/environment
# add brew executables locations to PATH
brew_path=$(brew shellenv|grep  '^export PATH' |sed -E 's/^export PATH="([^$]+)\$.*/\1/')
prependEtcEnvironmentPath "$brew_path"

# Validate the installation ad hoc
echo "Validate the installation reloading /etc/environment"
reloadEtcEnvironment

if ! command -v brew; then
    echo "brew was not installed"
    exit 1
fi
