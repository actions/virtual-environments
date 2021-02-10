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

# https://developer.apple.com/support/expiration/
# Enterprise iOS Distribution Certificates generated between February 7 and September 1st, 2020 will expire on February 7, 2023.
# Rotate the certificate before expiration to ensure your apps are installed and signed with an active certificate.
# Confirm that the correct intermediate certificate is installed by verifying the expiration date is set to 2030.
# sudo security delete-certificate -Z FF6797793A3CD798DC5B2ABEF56F73EDC9F83A64 /Library/Keychains/System.keychain
curl https://www.apple.com/certificateauthority/AppleWWDRCAG3.cer --output $HOME/AppleWWDRCAG3.cer --silent
sudo security add-trusted-cert -d -r unspecified -k /Library/Keychains/System.keychain $HOME/AppleWWDRCAG3.cer
rm $HOME/AppleWWDRCAG3.cer