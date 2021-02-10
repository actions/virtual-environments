#!/bin/bash -e
################################################################################
##  File:  gfortran.sh
##  Desc:  Installs GNU Fortran
################################################################################

function InstallFortran {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    if ! command -v $version; then
        echo "$version was not installed"
        exit 1
    fi
}

# Install GNU Fortran compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=(
    "gfortran-8"
    "gfortran-9"
)

for version in ${versions[*]}
do
    InstallFortran $version
done
