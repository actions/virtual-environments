#!/bin/bash

MINICONDA_INSTALLER="/tmp/miniconda.sh"
curl -sL https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o $MINICONDA_INSTALLER
chmod +x $MINICONDA_INSTALLER
sudo $MINICONDA_INSTALLER -b -p /usr/local/miniconda

sudo ln -s /usr/local/miniconda/bin/conda /usr/local/bin/conda

if [ -d "$HOME/.conda" ]; then
    sudo chown -R $USER "$HOME/.conda"
fi