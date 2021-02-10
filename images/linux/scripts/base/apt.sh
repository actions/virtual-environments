#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -yq update
apt-get -yq dist-upgrade
systemctl disable apt-daily.service
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.service

# Configure apt to always assume Y
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install aria2 and jq
apt-get install aria2
apt-get install jq
# Use apt-fast for parallel downloads
add-apt-repository -y ppa:apt-fast/stable
apt-get update
apt-get install apt-fast
