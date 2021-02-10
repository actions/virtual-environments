#!/bin/bash -e
################################################################################
##  File:  image-magick.sh
##  Desc:  Installs ImageMagick
################################################################################

# Install ImageMagick
apt-get install -y --no-install-recommends --fix-missing \
    imagemagick \
    libmagickcore-dev \
    libmagickwand-dev \
    libmagic-dev
