#!/bin/sh

###########################################################################
# The script downloads macos hosted tool cache for several Python versions 
# and installs them onto the system
#
###########################################################################

SOURCE_URL="https://vstsagenttools.blob.core.windows.net/tools"
PACKAGES_DIR=/tmp/hostedtoolcache

# Download hosted tool cache with azcopy
azcopy copy $SOURCE_URL $PACKAGES_DIR --include-path "hostedtoolcache/macos-10.13" --recursive
mv $PACKAGES_DIR/tools/hostedtoolcache/macos-10.13/* $PACKAGES_DIR

if [ $? -ne 0 ]; then
    echo "An error occured while downloading hostedtoolcache"
    exit 1
fi

# Install the tools from the hosted tool cache
packages=$(find $PACKAGES_DIR -name package.json)
for package in $packages; do
    pushd $(dirname $package)
    npm install
    popd
done;
