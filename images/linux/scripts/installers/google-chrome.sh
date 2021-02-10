#!/bin/bash -e
################################################################################
##  File:  google-chrome.sh
##  Desc:  Installs google-chrome  and chromedriver
################################################################################

LSB_RELEASE=$(lsb_release -rs)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt-get update
apt-get install -y google-chrome-stable
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v google-chrome; then
    echo "google-chrome was not installed"
    exit 1
fi

CHROME_VERSION=$(google-chrome --product-version)
CHROME_VERSION=${CHROME_VERSION%.*}

# Determine latest release of chromedriver
# Compatibility of Google Chrome and Chromedriver: https://sites.google.com/a/chromium.org/chromedriver/downloads/version-selection
LATEST_CHROMEDRIVER_VERSION=$(curl "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")

# Download and unpack latest release of chromedriver
echo "Downloading chromedriver v$LATEST_CHROMEDRIVER_VERSION..."
wget "https://chromedriver.storage.googleapis.com/$LATEST_CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip

CHROMEDRIVER_DIR="/usr/local/share/chrome_driver"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"

mkdir -p $CHROMEDRIVER_DIR
mv "chromedriver" $CHROMEDRIVER_BIN
chmod +x $CHROMEDRIVER_BIN
ln -s "$CHROMEDRIVER_BIN" /usr/bin/
echo "CHROMEWEBDRIVER=$CHROMEDRIVER_DIR" | tee -a /etc/environment

# Run tests to determine that the chromedriver installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v chromedriver; then
    echo "chromedriver was not installed"
    exit 1
fi
