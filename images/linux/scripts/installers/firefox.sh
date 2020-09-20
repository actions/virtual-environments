#!/bin/bash
################################################################################
##  File:  firefox.sh
##  Desc:  Installs Firefox
################################################################################


# Install Firefox
apt-get install -y firefox

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v firefox; then
    exit 1
fi

# add to gloabl system preferences for firefox locale en_US, because other browsers have en_US local.
# Default firefox local is en_GB
echo 'pref("intl.locale.requested","en_US");' >> "/usr/lib/firefox/browser/defaults/preferences/syspref.js"

# Download and unpack latest release of geckodriver
URL=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.assets[].browser_download_url | select(test("linux64.tar.gz$"))')
echo "Downloading geckodriver $URL"
wget "$URL" -O geckodriver.tar.gz
tar -xzf geckodriver.tar.gz
rm geckodriver.tar.gz

GECKODRIVER_DIR="/usr/local/share/gecko_driver"
GECKODRIVER_BIN="$GECKODRIVER_DIR/geckodriver"

mkdir -p $GECKODRIVER_DIR
mv "geckodriver" $GECKODRIVER_BIN

chmod +x $GECKODRIVER_BIN
ln -s "$GECKODRIVER_BIN" /usr/bin/
echo "GECKOWEBDRIVER=$GECKODRIVER_DIR" | tee -a /etc/environment

# Run tests to determine that the geckodriver installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v geckodriver; then
    echo "geckodriver was not installed"
    exit 1
fi
