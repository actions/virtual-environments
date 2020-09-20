#!/bin/bash

echo Additional NTP servers adding into /etc/ntp.conf file...
cat > /etc/ntp.conf << EOF
server 0.pool.ntp.org
server 1.pool.ntp.org
server 2.pool.ntp.org
server 3.pool.ntp.org
server time.apple.com
server time.windows.com
EOF

# Set the timezone to UTC.
echo The Timezone setting to UTC...
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
