#!/bin/bash
################################################################################
##  File:  install.sh
##  Desc:  Helper functions for installing tools
################################################################################

download_with_retries() {
# Due to restrictions of bash functions, positional arguments are used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"
    local COMPRESSED="$4"

    if [[ $COMPRESSED == "compressed" ]]; then
        COMMAND="curl $URL -4 -sL --compressed -o '$DEST/$NAME'"
    else
        COMMAND="curl $URL -4 -sL -o '$DEST/$NAME'"
    fi

    echo "Downloading $URL..."
    i=20
    while [ $i -gt 0 ]; do
        ((i--))
        eval $COMMAND
        if [ $? != 0 ]; then
            sleep 30
        else
            return 0
        fi
    done

    echo "Could not download $URL"
    return 1
}

## Use dpkg to figure out if a package has already been installed
## Example use:
## if ! IsPackageInstalled packageName; then
##     echo "packageName is not installed!"
## fi
function IsPackageInstalled {
    dpkg -S $1 &> /dev/null
}

verlte() {
    sortedVersion=$(echo -e "$1\n$2" | sort -V | head -n1)
    [  "$1" = "$sortedVersion" ]
}