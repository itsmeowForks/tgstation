#/bin/bash

EXECUTABLE_TMP=""
TARGET_TMP=""
if [[ $MODE == "32" ]]; then
    if [[ $TARGET_OS == "linux" ]]; then
        TARGET_TMP="i686-unknown-linux-gnu"
        EXECUTABLE_TMP="$LIBRARY_EXECUTABLE_LINUX_32"
    else if [[ $TARGET_OS == "windows" ]]; then
        TARGET="i686-pc-windows-msvc"
        EXECUTABLE_TMP="$LIBRARY_EXECUTABLE_WINDOWS_32"
    fi
else if [[ $MODE == "64" ]]; then
    if [[ $TARGET_OS == "linux" ]]; then
        TARGET_TMP="x86_64-unknown-linux-gnu"
        EXECUTABLE_TMP="$LIBRARY_EXECUTABLE_LINUX_64"
    else if [[ $TARGET_OS == "windows" ]]; then
        TARGET_TMP="x86_64-pc-windows-msvc"
        EXECUTABLE_TMP="$LIBRARY_EXECUTABLE_WINDOWS_64"
    fi
fi

export EXECUTABLE_NAME=$EXECUTABLE_TMP
export EXECUTABLE_TARGET=$TARGET_TMP
