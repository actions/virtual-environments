#!/bin/bash -e
################################################################################
##  File:  git.sh
##  Desc:  Installs Git
################################################################################

# Source the helpers for use with the script
source "$HELPER_SCRIPTS"/install.sh

## Install git
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install git -y
git --version

# Install git-lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt-get install -y --no-install-recommends git-lfs

# Install git-ftp
apt-get install git-ftp -y

# Run tests to determine that the software installed as expected
echo "Testing git installation"
if ! command -v git; then
    echo "git was not installed"
    exit 1
fi
echo "Testing git-lfs installation"
if ! command -v git-lfs; then
    echo "git-lfs was not installed"
    exit 1
fi
echo "Testing git-ftp installation"
if ! command -v git-ftp; then
    echo "git-ftp was not installed"
    exit 1
fi

#Install hub
tmp_hub="/tmp/hub"
mkdir -p "$tmp_hub"
url=$(curl -s https://api.github.com/repos/github/hub/releases/latest | jq -r '.assets[].browser_download_url | select(contains("hub-linux-amd64"))')
download_with_retries "$url" "$tmp_hub"
tar xzvf "$tmp_hub"/hub-linux-amd64-*.tgz --strip-components 1 -C "$tmp_hub"
mv "$tmp_hub"/bin/hub /usr/local/bin

if command -v hub; then
    echo "hub CLI was installed successfully"
else
    echo "[!] Hub CLI was not installed"
    exit 1
fi

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts
