#!/bin/bash -e
################################################################################
##  File:  codeql-bundle.sh
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

source $HELPER_SCRIPTS/install.sh

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
codeql_bundle_name="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/main/src/defaults.json | jq -r .bundleVersion)"
# Convert the bundle name to a version number (0.0.0-YYYYMMDD).
codeql_bundle_version="0.0.0-${codeql_bundle_name##*-}"

extraction_directory="$AGENT_TOOLSDIRECTORY/CodeQL/$codeql_bundle_version/x64"
mkdir -p "$extraction_directory"

echo "Downloading CodeQL bundle $codeql_bundle_version..."
download_with_retries "https://github.com/github/codeql-action/releases/download/$codeql_bundle_name/codeql-bundle.tar.gz" "/tmp" "codeql-bundle.tar.gz"
tar -xzf "/tmp/codeql-bundle.tar.gz" -C "$extraction_directory"

# Touch a special file that indicates to the CodeQL Action that this bundle was baked-in to the hosted runner images.
touch "$extraction_directory/pinned-version"

# Touch a file to indicate to the toolcache that setting up CodeQL is complete.
touch "$extraction_directory.complete"

# Test that the tool has been extracted successfully.
"$AGENT_TOOLSDIRECTORY/CodeQL/$codeql_bundle_version/x64/codeql/codeql" version
