source ~/utils/utils.sh

echo "Installing Microsoft Edge..."
brew cask install microsoft-edge

EDGE_INSTALLATION_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
EDGE_VERSION=$("$EDGE_INSTALLATION_PATH" --version | cut -d' ' -f 3)
EDGE_VERSION_MAJOR=$(echo $EDGE_VERSION | cut -d'.' -f 1)

echo "Version of Microsoft Edge: ${EDGE_VERSION}"

echo "Installing Microsoft Edge WebDriver..."

EDGE_DRIVER_VERSION_URL="https://msedgedriver.azureedge.net/LATEST_RELEASE_${EDGE_VERSION_MAJOR}"
EDGE_DRIVER_LATEST_VERSION=$(curl -s "$EDGE_DRIVER_VERSION_URL" | iconv -f utf-16 -t utf-8 | tr -d '\r')
EDGE_DRIVER_URL="https://msedgedriver.azureedge.net/${EDGE_DRIVER_LATEST_VERSION}/edgedriver_mac64.zip"

echo "Compatible version of WebDriver: ${EDGE_DRIVER_LATEST_VERSION}"

pushd "/tmp" > /dev/null
download_with_retries $EDGE_DRIVER_URL "." "edgedriver.zip"

# Move webdriver to the separate directory to be consistent with the docs
# https://docs.microsoft.com/en-us/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops#decide-how-you-will-deploy-and-test-your-app

APPLICATION="/usr/local/bin/msedgedriver"
EDGEDRIVER_DIR="/usr/local/share/edge_driver"
EDGEDRIVER_BIN="$EDGEDRIVER_DIR/msedgedriver"

mkdir -p $EDGEDRIVER_DIR

unzip "edgedriver.zip" -d $EDGEDRIVER_DIR
ln -s "$EDGEDRIVER_BIN" $APPLICATION
echo "export EDGEWEBDRIVER=${EDGEDRIVER_DIR}" >> "${HOME}/.bashrc"
popd > /dev/null

#Delete Microsoft autoupdate service to prevent autoupdates popup
AUTOUPDATE_START="$HOME/Library/Preferences/com.microsoft.autoupdate2.plist"
while [ ! -f "$AUTOUPDATE_START" ]
do
    echo "Wait for MS update automatic installation"
    sleep 30    
done

echo "kill autoupdate process"
ps -ef | grep [M]icrosoft | awk '{print $2}' | sudo xargs kill -9
echo "remove autupdate service"
sudo launchctl remove com.microsoft.autoupdate.helper

echo "delete autoupdate files"
sudo rm -rf "$HOME/Library/Application Support/Microsoft AU Daemon/"
sudo rm -rf "$HOME/Library/Application Support/Microsoft AutoUpdate/"
sudo rm -rf "$HOME/Library/Preferences/com.microsoft.autoupdate2.plist"
sudo rm -rf "$HOME/Library/Preferences/com.microsoft.autoupdate.fba.plist"
sudo rm -rf "$HOME/Library/Caches/com.microsoft.autoupdate2"
sudo rm -rf "/Library/Application Support/Microsoft/MAU2.0/"
sudo rm -rf "/Library/LaunchAgents/com.microsoft.update.agent.plist"
sudo rm -rf "/Library/PrivelegedHelperTools/com.microsoft.autoupdate.helper"
