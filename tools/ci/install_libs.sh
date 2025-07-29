#!/usr/bin/env bash
set -euo pipefail

export SCRIPT_ROOT=$(dirname -- "$( readlink -f -- "$0"; )")

# Set general build/architecture parameters
export MODE="32"
export TARGET_OS="linux"
export NATIVE_BUILD="yes"

# Runs download_install_all for all library types.
for script in $( find $SCRIPT_ROOT/libs/*/download_install_all.sh -type f ); do
    source $script
done
