#!/bin/bash

# Enable firewall. SSH and VNC opened. Can't did it at bootstrap step, so placed it here
defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Setting correct time zone
echo "Configuring system time to GMT..."
rm -f /etc/localtime
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari
# Safari’s executable is located at /usr/bin/safaridriver
# Configure Safari to Enable WebDriver Support
sudo safaridriver --enable

# Turn off hibernation and get rid of the sleepimage
sudo pmset hibernatemode 0
sudo rm -f /var/vm/sleepimage

# Change screen resolution to the maximum supported for 4Mb video memory
sudo "/Library/Application Support/VMware Tools/vmware-resolutionSet" 1176 885