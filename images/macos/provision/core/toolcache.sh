#!/bin/sh

# Download hosted tool cache with npm
NPM_FEED="npm.pkg.github.com"
TOOLSET_PATH="$HOME/image-generation/toolcache.json"

echo "Installing npm-toolcache..."
PACKAGE_LIST=($(jq -r 'keys | .[]' $TOOLSET_PATH))

# Execute in /tmp folder to avoid node_modules creation in $HOME
pushd /tmp

# GitHub Package Registry doesn't support downloading public packages without auth so we have to authorize
# Put the .npmrc to /tmp directory on the image to make sure that it will deleted after image generation
echo "Configure auth for github package registry"
echo "@actions:registry=https://${NPM_FEED}/" >> ".npmrc"
echo "//${NPM_FEED}/:_authToken=${GITHUB_FEED_TOKEN}" >> ".npmrc"

echo "Install packages..."
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

rm -f ".npmrc"

popd