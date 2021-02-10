#!/bin/bash
# set screensaver idleTime to 0, to prevent turning screensaver on
macUUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-62`

rm -rf /Users/$USERNAME/Library/Preferences/com.apple.screensaver.$macUUID.plist
rm -rf /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist
rm -rf /Users/$USERNAME/Library/Preferences/com.apple.screensaver.plist
rm -rf /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.plist

defaults write /Users/$USERNAME/Library/Preferences/com.apple.screensaver.$macUUID.plist idleTime -string 0
defaults write /Users/$USERNAME/Library/Preferences/com.apple.screensaver.$macUUID.plist CleanExit "YES"
defaults write /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist idleTime -string 0
defaults write /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist CleanExit "YES"
defaults write /Users/$USERNAME/Library/Preferences/com.apple.screensaver.plist idleTime -string 0
defaults write /Users/$USERNAME/Library/Preferences/com.apple.screensaver.plist CleanExit "YES"
defaults write /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.plist idleTime -string 0
defaults write /Users/$USERNAME/Library/Preferences/ByHost/com.apple.screensaver.plist CleanExit "YES"

chown -R $USERNAME:staff /Users/$USERNAME/Library/Preferences/ByHost/
chown -R $USERNAME:staff /Users/$USERNAME/Library/Preferences/

killall cfprefsd

# Set values to 0, to prevent sleep at all
pmset -a displaysleep 0 sleep 0 disksleep 0
