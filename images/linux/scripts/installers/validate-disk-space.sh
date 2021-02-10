#!/bin/bash -e
################################################################################
##  File:  validate-disk-space.sh
##  Desc:  Validate free disk space
################################################################################

availableSpaceMB=$(df / -hm | sed 1d | awk '{ print $4}')
minimumFreeSpaceMB=16000

echo "Available disk space: $availableSpaceMB MB"

if [ $RUN_VALIDATION != "true" ]; then
    echo "Skipping validation disk space..."
    exit 0
fi

if [ $availableSpaceMB -le $minimumFreeSpaceMB ]; then
    echo "Not enough disk space on the image (minimum available space: $minimumFreeSpaceMB MB)"
    exit 1
fi
