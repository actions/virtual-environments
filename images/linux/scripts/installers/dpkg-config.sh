#!/bin/bash -e

# This is the anti-frontend. It never interacts with you  at  all,
# and  makes  the  default  answers  be used for all questions. It
# might mail error messages to root, but that's it;  otherwise  it
# is  completely  silent  and  unobtrusive, a perfect frontend for
# automatic installs. If you are using this front-end, and require
# non-default  answers  to questions, you will need to preseed the
# debconf database
echo 'DEBIAN_FRONTEND=noninteractive' | tee -a /etc/environment

# dpkg can be instructed not to ask for confirmation
# when replacing a configuration file (with the --force-confdef --force-confold options)
cat <<EOF >> /etc/apt/apt.conf.d/10dpkg-options
Dpkg::Options {
  "--force-confdef";
  "--force-confold";
}
EOF

# hide information about packages that are no longer required
cat <<EOF >> /etc/apt/apt.conf.d/10apt-autoremove
APT::Get::AutomaticRemove "0";
APT::Get::HideAutoRemove "1";
EOF
