#!/bin/sh

# MongoDB object-value database
# installs last version of MongoDB Community Edition
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/v

echo "Installing mongodb..."

brew tap mongodb/brew
brew install mongodb-community