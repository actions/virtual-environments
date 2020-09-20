#!/bin/bash
################################################################################
##  File:  rust.sh
##  Desc:  Installs Rust
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

export RUSTUP_HOME=/usr/share/rust/.rustup
export CARGO_HOME=/usr/share/rust/.cargo

curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain=stable --profile=minimal

# Initialize environment variables
source $CARGO_HOME/env

# Install common tools
rustup component add rustfmt clippy
cargo install bindgen cbindgen
cargo install cargo-audit
cargo install cargo-outdated

echo "Test installation of the Rust toochain"

# Permissions
chmod -R 777 $(dirname $RUSTUP_HOME)

for cmd in rustup rustc rustdoc cargo rustfmt cargo-clippy bindgen cbindgen 'cargo audit' 'cargo outdated'; do
    if ! command -v $cmd --version; then
        echo "$cmd was not installed or is not found on the path"
        exit 1
    fi
done

# Cleanup Cargo cache
rm -rf ${CARGO_HOME}/registry/*

# Update /etc/environemnt
prependEtcEnvironmentPath "${CARGO_HOME}/bin"

# Rust Symlinks are added to a default profile /etc/skel
pushd /etc/skel
ln -sf $RUSTUP_HOME .rustup
ln -sf $CARGO_HOME .cargo
popd
