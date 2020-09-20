#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
export PATH="$HOME/.ghcup/bin:$PATH"
echo 'export PATH="$PATH:$HOME/.ghcup/bin"' >> "$HOME/.bashrc"

availableVersions=$(ghcup list | grep -v "prerelease" | grep "ghc " | awk '{print $3}')
minorMajorVersions=$(echo "$availableVersions" | cut -d"." -f 1,2 | uniq | tail -n3)
for majorMinorVersion in $minorMajorVersions; do
    fullVersion=$(echo "$availableVersions" | grep "$majorMinorVersion." | tail -n1)
    echo "install ghc version $fullVersion..."
    ghcup install $fullVersion
    ghcup set $fullVersion
done

echo "install cabal..."
ghcup install-cabal
