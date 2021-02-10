#!/bin/bash

echo "Get the latest Stack version..."
StackRelease=$(curl -s "https://api.github.com/repos/commercialhaskell/stack/releases/latest")
DownloadUrl=$(echo $StackRelease | jq -r '.assets[].browser_download_url | select(contains("osx-x86_64.tar.gz"))' | head -n 1)
StackVersion=$(echo $StackRelease | jq -r '.name' | cut -c2-)
StackArchive="/tmp/stack.tar.gz"

echo "Download stack version $StackVersion..."
wget $DownloadUrl -O $StackArchive

StackToolcachePath="$AGENT_TOOLSDIRECTORY/stack/$StackVersion"
DestinationPath="$StackToolcachePath/x64"

mkdir -p $DestinationPath

echo "Unzip stack archive..."
tar -xzf $StackArchive -C $DestinationPath --strip 1

touch $StackToolcachePath/x64.complete

echo "export PATH="\$PATH":$DestinationPath" >> "$HOME/.bashrc"
