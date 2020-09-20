#!/bin/bash
################################################################################
##  File:  ruby.sh
##  Desc:  Installs Ruby requirements
################################################################################


sudo apt-get install ruby-full
sudo gem update --system

# Install Ruby requirements
apt-get install -y libz-dev openssl libssl-dev
