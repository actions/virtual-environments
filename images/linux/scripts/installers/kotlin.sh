#!/bin/bash -e
################################################################################
##  File:  kotlin.sh
##  Desc:  Installs Kotlin
################################################################################

source $HELPER_SCRIPTS/install.sh

URL=$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases/latest | jq -r '.assets[].browser_download_url | select(contains("kotlin-compiler"))')
download_with_retries $URL "/tmp"

unzip -qq /tmp/kotlin-compiler*.zip -d /tmp
FILES="/tmp/kotlinc/bin/*"

for f in $FILES
do
    if [[ "$f" != *".bat"* ]]; then
      chmod +x "$f"
      mv "$f" /usr/local/bin
    fi
done

invoke_tests "Tools" "Kotlin"