#!/bin/bash

# Fix permissions for the Rust folder
# https://github.com/actions/virtual-environments/issues/572
rust_folder="/usr/share/rust"
if [ -d "$rust_folder" ]; then
    rust_folder_owner=$(ls -ld $rust_folder | awk '{print $3}')
    if [ "$USER" != "$rust_folder_owner" ]; then
        chown "$USER":docker -R $rust_folder
    fi
fi
