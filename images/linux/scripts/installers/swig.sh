#!/bin/bash


# Install Swig
sudo apt-get install -y swig

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v swig; then
    echo "Swig was not installed"
    exit 1
fi
