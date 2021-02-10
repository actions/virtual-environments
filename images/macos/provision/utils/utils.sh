download_with_retries() {
# Due to restrictions of bash functions, positional arguments are used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"

    echo "Downloading $URL..."
    wget $URL   --output-document="$DEST/$NAME" \
                --tries=30 \
                --wait 30 \
                --retry-connrefused \
                --retry-on-host-error \
                --retry-on-http-error=429,500,502,503 \
                --no-verbose

    if [ $? != 0 ]; then
        echo "Could not download $URL; Exiting build!"
        exit 1
    fi

    return 0
}

is_BigSur() {
    if [ "$OSTYPE" = "darwin20" ]; then
        true
    else
        false
    fi
}

is_Catalina() {
    if [ "$OSTYPE" = "darwin19" ]; then
        true
    else
        false
    fi
}

is_Mojave() {
    if [ "$OSTYPE" = "darwin18" ]; then
        true
    else
        false
    fi
}

is_HighSierra() {
    if [ "$OSTYPE" = "darwin17" ]; then
        true
    else
        false
    fi
}

is_Less_Catalina() {
    if is_HighSierra || is_Mojave; then
        true
    else
        false
    fi
}

is_Less_BigSur() {
    if is_HighSierra || is_Mojave || is_Catalina; then
        true
    else
        false
    fi
}

get_toolset_path() {
    echo "$HOME/image-generation/toolset.json"
}

get_toolset_value() {
    local toolset_path=$(get_toolset_path)
    local query=$1
    echo "$(jq -r "$query" $toolset_path)"
}

get_xcode_list_from_toolset() {
    echo $(get_toolset_value '.xcode.versions | reverse | .[]')
}

get_latest_xcode_from_toolset() {
    echo $(get_toolset_value '.xcode.versions[0]')
}

get_default_xcode_from_toolset() {
    echo $(get_toolset_value '.xcode.default')
}

verlte() {
    sortedVersion=$(echo -e "$1\n$2" | sort -V | head -n1)
    [  "$1" = "$sortedVersion" ]
}