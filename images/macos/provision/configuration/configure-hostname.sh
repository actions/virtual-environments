#!/bin/bash

# Add script for changing hostname to run on startup to prevent duplicate hostnames across the environment. Hostname and Computername should contain .local in name to avoid name resolution issues
tee -a /usr/local/bin/change_hostname.sh > /dev/null <<\EOF
#!/bin/bash

name="Mac-$(python -c 'from time import time; print int(round(time() * 1000))')"
scutil --set HostName "${name}.local"
scutil --set LocalHostName $name
scutil --set ComputerName "${name}.local"
EOF

chmod +x "/usr/local/bin/change_hostname.sh"

sudo tee -a /Library/LaunchDaemons/change_hostname.plist > /dev/null <<\EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
        <dict>
                <key>Label</key>
                <string>change-hostname</string>
                <key>Program</key>
                <string>/usr/local/bin/change_hostname.sh</string>
                <key>RunAtLoad</key>
                <true/>
        </dict>
</plist>
EOF