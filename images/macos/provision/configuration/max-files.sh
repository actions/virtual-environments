#!/bin/bash

set -e

Launch_Daemons="/Library/LaunchDaemons"

# EOF in quotes to disable variable expansion
echo "Creating limit.maxfiles.plist"
cat > "${Launch_Daemons}/limit.maxfiles.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>52428</string>
      <string>524288</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>
EOF

echo "limit.maxfiles.plist permissions changing"
chown root:wheel "${Launch_Daemons}/limit.maxfiles.plist"
chmod 0644 "${Launch_Daemons}/limit.maxfiles.plist"


echo "Done, limit.maxfiles has been updated"

