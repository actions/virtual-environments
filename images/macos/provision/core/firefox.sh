echo "Installing Firefox..."
brew cask install firefox

echo "Installing Geckodriver..."
brew install geckodriver

echo "Add GECKOWEBDRIVER to bashrc..."
echo "export GECKOWEBDRIVER=$(brew --prefix geckodriver)/bin" >> "${HOME}/.bashrc"