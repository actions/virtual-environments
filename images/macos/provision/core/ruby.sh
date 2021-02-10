#!/bin/sh

set -e

source ~/utils/utils.sh

echo Installing Ruby...
if is_Less_BigSur; then
    # We can't install latest ruby 2.7 as a default version related with bug
    # https://github.com/fastlane/fastlane/issues/15397
    /usr/local/bin/brew install ruby@2.6
    ln -sf /usr/local/opt/ruby\@2.6 /usr/local/opt/ruby
else
    brew install ruby
fi


