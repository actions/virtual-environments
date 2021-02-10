#!/bin/bash
set -e

AZCOPY_DOWNLOAD_URL="https://aka.ms/downloadazcopy-v10-mac"

wget -O "$HOME/azcopy.zip" "$AZCOPY_DOWNLOAD_URL"
unzip azcopy.zip -d azcopy
AZCOPY_EXTRACTED=$(echo azcopy/azcopy*)
cp "$AZCOPY_EXTRACTED/azcopy" "/usr/local/bin/azcopy"
chmod +x "/usr/local/bin/azcopy"

echo "Done, cleaning up"
rm -rf azcopy*
