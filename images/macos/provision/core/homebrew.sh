#!/bin/sh
echo "Installing Homebrew..."

source ~/utils/utils.sh

echo Installing Homebrew...
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo Disabling Homebrew analytics...
brew analytics off

echo Installing the last version of curl
brew install curl

echo Installing wget...
brew install wget

echo Installing jq
brew install jq

# init brew bundle feature
brew tap Homebrew/bundle