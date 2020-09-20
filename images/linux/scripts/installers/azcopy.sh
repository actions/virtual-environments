#!/bin/bash
################################################################################
##  File:  azcopy.sh
##  Desc:  Installs AzCopy
################################################################################


# Install AzCopy7
wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinux64
tar -xf azcopy.tar.gz
rm azcopy.tar.gz
./install.sh

# Install AzCopy10
wget -O /tmp/azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux
tar zxvf /tmp/azcopy.tar.gz --strip-components=1 -C /tmp
mv /tmp/azcopy /usr/local/bin/azcopy10
chmod +x /usr/local/bin/azcopy10

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v azcopy; then
    echo "azcopy7 was not installed"
    exit 1
fi

if ! command -v azcopy10; then
    echo "azcopy10 was not installed"
    exit 1
fi
