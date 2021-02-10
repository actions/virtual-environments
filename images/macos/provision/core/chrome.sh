echo "Installing Chrome..."
brew cask install google-chrome

echo "Installing Chrome Driver"
brew cask install chromedriver

echo "Installing Selenium"
brew install selenium-server-standalone

CHROMEWEBDRIVER_DIR=$(readlink $(which chromedriver) | xargs dirname)
echo "export CHROMEWEBDRIVER=$CHROMEWEBDRIVER_DIR" >> "${HOME}/.bashrc"