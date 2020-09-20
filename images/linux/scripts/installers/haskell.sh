#!/bin/bash
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

# Install Herbert V. Riedel's PPA for managing multiple version of ghc on ubuntu.
# https://launchpad.net/~hvr/+archive/ubuntu/ghc
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

# Get 3 latest Haskell Major.Minor versions
allGhcVersions=$(apt-cache search "^ghc-" | grep -Po '(\d*\.){2}\d*' | sort --unique --version-sort)
ghcMajorMinorVersions=$(echo "$allGhcVersions" | cut -d "." -f 1,2 | sort --unique --version-sort | tail -3)

for version in $ghcMajorMinorVersions; do
    # Get latest patch version for given Major.Minor one (ex. 8.6.5 for 8.6) and install it
    exactVersion=$(echo "$allGhcVersions" | grep $version | sort --unique --version-sort | tail -1)
    apt-get install -y ghc-$exactVersion
    ghcInstalledVersions+=("$exactVersion")
    defaultGHCVersion=$exactVersion
done

# Get latest cabal version
cabalVersion=$(apt-cache search cabal-install-[0-9] | grep -Po '\d*\.\d*' | sort --unique --version-sort | tail -1)

apt-get install -y cabal-install-$cabalVersion

# Install the latest stable release of haskell stack
curl -sSL https://get.haskellstack.org/ | sh

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
# Check all ghc versions
for version in ${ghcInstalledVersions[@]}; do
    if ! command -v /opt/ghc/$version/bin/ghc; then
        echo "ghc $version was not installed"
        exit 1
    fi
done

# Check cabal
if ! command -v /opt/cabal/$cabalVersion/bin/cabal; then
    echo "cabal $cabalVersion was not installed"
    exit 1
fi

# Check stack
if ! command -v stack; then
    exit 1
fi

# Create symlink for ghc and cabal in /usr/bin
ln -s "/opt/ghc/$defaultGHCVersion/bin/ghc" "/usr/bin/ghc"
ln -s "/opt/cabal/$cabalVersion/bin/cabal" "/usr/bin/cabal"
