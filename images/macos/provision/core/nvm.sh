#!/bin/sh

###########################################################################
# The script installs node version manager with node versions 6,8,10 and 12
#
###########################################################################
source ~/utils/utils.sh

VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash

if [ $? -eq 0 ]; then
        . ~/.bashrc
        nvm --version
        nvm install lts/boron # 6.x
        nvm install lts/carbon # 8.x
        nvm install lts/dubnium # 10.x
        nvm install lts/erbium # 12.x
        nvm install v13 # 13.x
        nvm install v14 # 14.x
        nvm alias node6 lts/boron
        nvm alias node8 lts/carbon
        nvm alias node10 lts/dubnium
        nvm alias node12 lts/erbium
        nvm alias node13 v13
        nvm alias node14 v14

        if is_Catalina || is_BigSur; then
                # set system node as default
                nvm alias default system
        fi
else
        echo error
fi

echo "Node version manager has been installed successfully"
