createXamarinProvisionatorSymlink() {
    local XCODE_VERSION="$1"
    local FULL_VERSION=$(echo "${XCODE_VERSION}.0.0" | cut -d'.' -f 1,2,3)

    if [ $FULL_VERSION != $XCODE_VERSION ]; then
        ln -sf "/Applications/Xcode_${XCODE_VERSION}.app" "/Applications/Xcode_${FULL_VERSION}.app"
    fi
}

getXcodeVersionToInstall() {
    local XCODE_VERSION="$1"

    if  [[ ! $XCODE_VERSION =~ "_beta" ]]; then
        echo "${XCODE_VERSION//_/ }"
    else
        local XCODE_BETA="${XCODE_VERSION/_/ }"
        echo "$(xcversion list | sort -r | grep -m 1 "$XCODE_BETA")"
    fi
}

validateXcodeIntegrity() {
    local WORKING_DIR="$1"
    local XCODE_VERSION="$2"

    if echo $XCODE_VERSION | grep "beta"; then
        return 0
    fi

    spctl --assess --raw "${WORKING_DIR}/Xcode.app"
}

approveLicense() {
    local XCODE_VERSION="$1"
    sudo "/Applications/Xcode_${XCODE_VERSION}.app/Contents/Developer/usr/bin/xcodebuild" -license accept
}

installAdditionalPackages() {
    # should be called only for old High Sierra and Mojave
    local XCODE_VERSION="$1"
    find /Applications/Xcode_${XCODE_VERSION}.app/Contents/Resources/Packages/ -name '*.pkg' | xargs -I '{}' sudo installer -pkg '{}' -target / -allowUntrusted
}

runFirstLaunch() {
    local XCODE_VERSION="$1"
    sudo "/Applications/Xcode_${XCODE_VERSION}.app/Contents/Developer/usr/bin/xcodebuild" -runFirstLaunch
}

setXcodeDeveloperDirVariables() {
    stable_xcode_versions=$(get_xcode_list_from_toolset | tr " " "\n" | grep -v "beta")
    major_versions=($(echo ${stable_xcode_versions[@]} | tr " " "\n" | cut -d '.' -f 1 | uniq))
    for MAJOR_VERSION in "${major_versions[@]}"
    do
        LATEST_STABLE_VERSION=$(echo "${stable_xcode_versions[*]}" | grep "${MAJOR_VERSION}" | tail -n 1)
        echo "export XCODE_${MAJOR_VERSION}_DEVELOPER_DIR=/Applications/Xcode_${LATEST_STABLE_VERSION}.app/Contents/Developer" >> "$HOME/.bashrc"
    done
}

extractXcodeXip() {
    local WORKING_DIR="$1"
    local XCODE_VERSION="$2"
    XCODE_XIP="${WORKING_DIR}/Xcode_${XCODE_VERSION// /_}.xip"

    open -W $XCODE_XIP

    if [[ -d "${WORKING_DIR}/Xcode-beta.app" ]]; then
        mv -f "${WORKING_DIR}/Xcode-beta.app" "${WORKING_DIR}/Xcode.app"
    fi

    if [[ ! -d "${WORKING_DIR}/Xcode.app" ]]; then
        echo "'Xcode.app' doesn't exist after Xcode XIP extraction"
        exit 1
    fi
}

createBetaSymlink() {
    local XCODE_VERSION=$1
    if [[ $XCODE_VERSION =~ 1[01].* ]] || [[ $XCODE_VERSION == "12" ]]; then
        ln -sf "/Applications/Xcode_${XCODE_VERSION}.app" "/Applications/Xcode_${XCODE_VERSION}_beta.app"
    fi
}