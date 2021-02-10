#!/bin/bash -e
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################

# Install
image_label="$(lsb_release -rs)"
swift_version=$(curl -s -L -N https://swift.org/download|awk -F"[ <]" '/id="swift-/ {print $4; exit}')

wget -P /tmp https://swift.org/builds/swift-$swift_version-release/ubuntu${image_label//./}/swift-$swift_version-RELEASE/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz

tar xzf /tmp/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz
mv swift-$swift_version-RELEASE-ubuntu$image_label /usr/share/swift

SWIFT_PATH="/usr/share/swift/usr/bin"
SWIFT_BIN="$SWIFT_PATH/swift"
ln -s "$SWIFT_BIN" /usr/local/bin/swift
echo "SWIFT_PATH=$SWIFT_PATH" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v swift; then
    echo "Swift was not installed"
    exit 1
fi
