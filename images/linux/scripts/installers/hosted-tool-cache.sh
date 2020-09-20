#!/bin/bash
################################################################################
##  File:  hosted-tool-cache.sh
##  Desc:  Downloads and installs hosted tools cache
################################################################################


# Fail out if any setups fail
set -e

TOOLCACHE_REGISTRY="npm.pkg.github.com"

echo "Configure npm to use github package registry for '@actions' scope"
npm config set @actions:registry "https://${TOOLCACHE_REGISTRY}"

# Execute in /imagegeneration/installers folder to avoid node_modules creation in $HOME
pushd $INSTALLER_SCRIPT_FOLDER

# GitHub Package Registry doesn't support downloading public packages without auth so we have to authorize
echo "Configure auth for github package registry"
echo "//${TOOLCACHE_REGISTRY}/:_authToken=${GITHUB_FEED_TOKEN}" > ".npmrc"

echo "Installing npm-toolcache..."
TOOLSET_PATH="$INSTALLER_SCRIPT_FOLDER/toolcache.json"

PACKAGE_LIST=($(jq -r 'keys | .[]' $TOOLSET_PATH))

for PACKAGE_NAME in ${PACKAGE_LIST[@]}; do
    PACKAGE_VERSIONS=($(jq -r ".[\"$PACKAGE_NAME\"] | .[]" $TOOLSET_PATH))
    for PACKAGE_VERSION in ${PACKAGE_VERSIONS[@]}; do
        echo "Install ${PACKAGE_NAME}@${PACKAGE_VERSION}"
        npm install ${PACKAGE_NAME}@${PACKAGE_VERSION}

        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            echo "${PACKAGE_NAME}@${PACKAGE_VERSION} installation failure;  Error:${exit_code}"

            exit 1
        fi
    done;
done;

popd
