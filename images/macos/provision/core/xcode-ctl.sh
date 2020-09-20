#!/bin/bash

# Homebrew doesn't support installation of command line tools on MacOS 11.0
# https://github.com/Homebrew/install/blob/master/install.sh#L191
# Copy-paste script from brew installation process
# https://github.com/Homebrew/install/blob/master/install.sh#L530
# This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools

clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
touch $clt_placeholder
clt_label=`/usr/sbin/softwareupdate -l |
                      grep -B 1 -E 'Command Line Tools' |
                      awk -F'*' '/^ *\\*/ {print \$2}' |
                      sed -e 's/^ *Label: //' -e 's/^ *//' |
                      sort -V |
                      tail -n1`
/usr/sbin/softwareupdate -i "$clt_label"
rm -f $clt_placeholder
sudo xcode-select --switch "/Library/Developer/CommandLineTools/"