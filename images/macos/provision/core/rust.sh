#!/bin/sh

set -e

echo Installing Rustup...
brew install rustup-init

echo Installing Rust language...
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo Initialize environment variables...
CARGO_HOME=$HOME/.cargo
source $CARGO_HOME/env

echo Install common tools...
cargo install bindgen cbindgen cargo-audit cargo-outdated

echo Cleanup Cargo registry cached data...
rm -rf $CARGO_HOME/registry/*