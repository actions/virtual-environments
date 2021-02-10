#!/bin/sh
source ~/utils/utils.sh

echo Updating RubyGems...
gem update --system

echo Installing xcode-install utility...
gem install xcode-install --force

echo Installing CocoaPods...
gem install cocoapods

if is_Less_BigSur; then
    # fix nomad-cli installation
    if is_HighSierra; then
        brew install libxml2
        gem install nokogiri -v 1.6.8.1 -- --use-system-libraries --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
    fi

    echo Installing nomad-cli...
    gem install nomad-cli
fi

echo Installing xcpretty...
gem install xcpretty

echo Installing bundler...
gem install bundler --force

echo Installing fastlane tools...
gem install fastlane