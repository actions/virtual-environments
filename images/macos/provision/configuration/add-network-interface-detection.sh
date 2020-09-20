#!/bin/sh

# This script was taken from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/add-network-interface-detection.sh
# Distributed by MIT license, license can be found at the bottom of this script

# This script adds a Mac OS Launch Daemon, which runs every time the
# machine is booted. The daemon will re-detect the attached network
# interfaces. If this is not done, network devices may not work.
PLIST=/Library/LaunchDaemons/sonoma.detectnewhardware.plist
cat <<EOF > "${PLIST}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>sonoma.detectnewhardware</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/sbin/networksetup</string>
        <string>-detectnewhardware</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

# These should be already set as follows, but since they're required
# in order to load properly, we set them explicitly.
/bin/chmod 644 "${PLIST}"
/usr/sbin/chown root:wheel "${PLIST}"


: '
The MIT License (MIT)
Copyright (c) 2013-2017 Timothy Sutton
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'