#!/bin/bash

# Fix permissions for Homebrew
# https://github.com/actions/virtual-environments/issues/1568
brew_folder="/home/linuxbrew/"
if [ -d "$brew_folder" ]; then
    brew_folder_owner=$(ls -ld $brew_folder | awk '{print $3}')
    if [ "$USER" != "$brew_folder_owner" ]; then
        chown "$USER":docker -R $brew_folder
    fi
fi
