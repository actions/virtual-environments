#!/bin/bash -e
################################################################################
##  File:  example.sh
##  Desc:  This is an example script that can be copied to add a new software
##         installer to the image
################################################################################

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if [ -z $EXAMPLE_VAR ]; then
    $EXAMPLE_VAR=1.0.0
else
    echo "Example variable already set to $EXAMPLE_VAR"
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if [ -z $EXAMPLE_VAR ]; then
    echo "EXAMPLE_VAR variable was not set as expected"
    exit 1
else
    echo "EXAMPLE_VAR was set properly"
fi
