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

echo "grant microphone permission for simulators"
sudo sqlite3 ~/Library/Application\ Support/com.apple.TCC/TCC.db "insert into access values('kTCCServiceMicrophone','com.apple.CoreSimulator.SimulatorTrampoline', 0,1,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576347152)"
sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "insert into access values('kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh', 1,1,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342)"
sudo sqlite3 ~/Library/Application\ Support/com.apple.TCC/TCC.db "insert into access values('kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh', 1,1,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342)"
