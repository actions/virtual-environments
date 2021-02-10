#!/bin/bash -e
################################################################################
##  File:  nvm.sh
##  Desc:  Installs Nvm
################################################################################

export NVM_DIR="/etc/skel/.nvm"
mkdir $NVM_DIR
VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash
echo 'export NVM_DIR=$HOME/.nvm' | tee -a /etc/skel/.bash_profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' | tee -a /etc/skel/.bash_profile
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

# set system node.js as default one
nvm alias default system
