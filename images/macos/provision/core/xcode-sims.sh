#!/bin/sh

source ~/utils/utils.sh

# Downloading and installing simulators
SIMS_TO_INSTALL=(
"8.4"
"9.0"
"9.1"
"9.2"
"9.3"
"10.0"
"10.1"
"10.2"
"10.3"
)

for SIM_VERSION in ${SIMS_TO_INSTALL[@]}
do
    echo "Installing iOS $SIM_VERSION ..."
    sudo xcversion simulators --install="iOS ${SIM_VERSION}"
    echo "Successfuly installed iOS $SIM_VERSION ..."
done

echo "Done installing simulator runtimes."
