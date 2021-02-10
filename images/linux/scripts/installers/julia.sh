#!/bin/bash -e
################################################################################
##  File:  julia.sh
##  Desc:  Installs Julia, and adds Julia to the path
################################################################################

# This function fetches the latest Julia release from the GitHub API
# Based on https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
function GetLatestJuliaRelease () {
    curl --silent "https://api.github.com/repos/julialang/julia/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    sed 's/v//' # remove v prefix
}


# This function installs Julia using the specified arguments:
#   $1=MajorAndMinorVersion (1.3.1)
#   $2=IsDefaultVersion (true or false)

function InstallJulia () {
    # Extract Major and Minor version from full version string
    juliaMajorAndMinorVersion="$(cut -d. -f1,2 <<< $1)"
    juliaInstallationPath="/usr/local/julia$1"

    curl -sL "https://julialang-s3.julialang.org/bin/linux/x64/$juliaMajorAndMinorVersion/julia-$1-linux-x86_64.tar.gz" -o "julia-$1-linux-x86_64.tar.gz"
    mkdir -p "$juliaInstallationPath"
    tar -C "$juliaInstallationPath" -xzf "julia-$1-linux-x86_64.tar.gz" --strip-components=1
    rm "julia-$1-linux-x86_64.tar.gz"

    # If this version of Julia is to be the default version,
    # symlink it into the path
    if [ "$2" = true ]; then
        ln -s "$juliaInstallationPath/bin/julia" /usr/bin/julia
    fi

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"

    # If this version of Julia is to be the default version,
    # check that it has been added to PATH
    if [ "$2" = true ]; then
        if ! command -v julia; then
            echo "Julia was not installed or found on PATH"
            exit 1
        fi
    fi

    # Verify output of julia --version
    if [ ! "$($juliaInstallationPath/bin/julia --version)" = "julia version $1" ]; then
        echo "Julia was not installed correctly"
        exit 1
    fi
}

InstallJulia "$(GetLatestJuliaRelease)" true
