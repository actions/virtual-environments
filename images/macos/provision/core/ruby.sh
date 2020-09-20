#!/bin/sh

set -e

if [ $(id -u) -eq 0 ]; then
    echo "This script can not run as root. Aborting..."
    exit 1
fi

# We can't install latest ruby 2.7 as a default version related with bug
# https://github.com/fastlane/fastlane/issues/15397
echo Installing Ruby...
/usr/local/bin/brew install ruby@2.6
ln -sf /usr/local/opt/ruby\@2.6 /usr/local/opt/ruby
