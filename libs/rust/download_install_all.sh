#!/bin/bash


for LIB_INFO_PATH in $( find $SCRIPT_ROOT/libs/rust/*/lib_info.sh -type f ); do
    LIB_FOLDER=$(echo $LIB_INFO_PATH | cut -c $(echo "$SCRIPT_ROOT/libs/rust/" | wc -c)- | rev | cut -c $(echo "/lib_info.sh" | wc -c)- | rev)
    source $LIB_INFO_PATH
    if [[ $LIB_FOLDER != $LIBRARY_NAME ]]
        echo "Folder name '$LIB_FOLDER' does not match $LIB_INFO_PATH->LIBRARY_NAME of $LIBRARY_NAME! Skipping." >&2
        continue
    fi
    source $SCRIPT_ROOT/libs/rust/scripts/executable_info.sh
    source $SCRIPT_ROOT/libs/rust/scripts/download.sh
    source $SCRIPT_ROOT/libs/rust/scripts/install.sh
done
