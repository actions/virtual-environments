#!/bin/bash

echo Installing aws...
brew install awscli

echo Installing aws sam cli...
brew tap aws/tap
brew install aws-sam-cli

echo "Install aws cli session manager"
brew cask install session-manager-plugin
