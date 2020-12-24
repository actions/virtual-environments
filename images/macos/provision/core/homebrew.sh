#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Homebrew..."
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

echo "Installing jq..."
brew install jq

echo "Installing the latest curl..."
brew_install "curl"

echo "Installing wget..."
brew_install "wget"

# init brew bundle feature
brew tap Homebrew/bundle