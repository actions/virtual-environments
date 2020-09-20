#!/bin/bash
################################################################################
##  File:  docker-moby.sh
##  Desc:  Installs docker onto the image
################################################################################
set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# There is no stable docker-moby for Ubuntu 20 at the moment
if isUbuntu20 ; then
    add-apt-repository "deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/20.04/prod testing main"
fi

# Check to see if docker is already installed
docker_package=moby
echo "Determing if Docker ($docker_package) is installed"
if ! IsPackageInstalled $docker_package; then
    echo "Docker ($docker_package) was not found. Installing..."
    apt-get remove -y moby-engine moby-cli
    apt-get update
    apt-get install -y moby-engine moby-cli
    apt-get install --no-install-recommends -y moby-buildx
else
    echo "Docker ($docker_package) is already installed"
fi

# Enable docker.service
systemctl is-active --quiet docker.service || systemctl start docker.service
systemctl is-enabled --quiet docker.service || systemctl enable docker.service

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
echo "Checking the docker-moby and moby-buildx"
if ! command -v docker; then
    echo "docker was not installed"
    exit 1
elif ! [[ $(docker buildx) ]]; then
    echo "Docker-Buildx was not installed"
    exit 1
else
    echo "Docker-moby and Docker-buildx checking the successfull"
    # Docker daemon takes time to come up after installing
    sleep 10
    docker info
fi

# Pull images
toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
images=$(jq -r '.docker.images[]' $toolset)
for image in $images; do
    docker pull "$image"
done
