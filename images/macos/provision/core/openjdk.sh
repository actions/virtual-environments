#!/bin/sh

set -e

source ~/utils/utils.sh

installAzulJDK() {
    local URL=$1
    local TMP_FILE=/tmp/openjdk.dmg
    local TMP_MOUNT=`/usr/bin/mktemp -d /tmp/zulu.XXXX`
    # Download dmg
    curl "${URL}" -o "${TMP_FILE}"
    # Attach dmg
    hdiutil attach "${TMP_FILE}" -mountpoint "${TMP_MOUNT}"
    # Install pkg
    sudo installer -pkg "${TMP_MOUNT}/"*.pkg -target /
    # Detach dmg
    hdiutil detach "${TMP_MOUNT}"
    # Remove dmg
    rm -rf "${TMP_FILE}"
}

createEnvironmentVariable() {
    local VARIABLE_NAME=$1
    local JAVA_VERSION=$2
    if [[ $JAVA_VERSION == "7" || $JAVA_VERSION == "8" ]]; then
        JAVA_VERSION="1.${JAVA_VERSION}"
    fi
    local JAVA_PATH=$(/usr/libexec/java_home -v${JAVA_VERSION})
    echo "export ${VARIABLE_NAME}=${JAVA_PATH}" >> "${HOME}/.bashrc"
}

brew tap AdoptOpenJDK/openjdk

JAVA_VERSIONS_LIST=($(get_toolset_value '.java.versions | .[]'))
JAVA_DEFAULT=$(get_toolset_value '.java.default')
for JAVA_VERSION in "${JAVA_VERSIONS_LIST[@]}"
do
    if [[ $JAVA_VERSION == "7" ]]; then
        installAzulJDK "https://cdn.azul.com/zulu/bin/zulu7.40.0.15-ca-jdk7.0.272-macosx_x64.dmg"
    else
        brew cask install "adoptopenjdk${JAVA_VERSION}"
    fi
    createEnvironmentVariable "JAVA_HOME_${JAVA_VERSION}_X64" $JAVA_VERSION
done

createEnvironmentVariable "JAVA_HOME" $JAVA_DEFAULT

echo Installing Maven...
brew install maven

echo Installing Gradle ...
brew install gradle