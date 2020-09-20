echo "Installing Python Tooling"

echo "Brew Installing Python 3"
/usr/local/bin/brew install python3

echo "Brew Installing Python 2"
# Create local tap with formula due to python2 formula depreciation 
/usr/local/bin/brew tap-new local/python2
FORMULA_PATH=$(/usr/local/bin/brew extract python@2 local/python2 | grep "Homebrew/Library/Taps")
/usr/local/bin/brew install $FORMULA_PATH
