#!/bin/bash -e
################################################################################
##  File:  snap-environment.sh
##  Desc:  Update /etc/environment to include /snap/bin in PATH
##         because /etc/profile.d is ignored by `--norc` shell launch option
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/etc-environment.sh

# Update /etc/environemnt
prependEtcEnvironmentPath "/snap/bin"
