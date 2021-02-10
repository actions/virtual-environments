#!/bin/bash

echo "install soundflower"
brew cask install soundflower

echo "install switchaudio-osx"
brew install switchaudio-osx

echo "install sox"
brew install sox

echo "set Soundflower (2ch) as input/output device"
SwitchAudioSource -s "Soundflower (2ch)" -t input
SwitchAudioSource -s "Soundflower (2ch)" -t output
