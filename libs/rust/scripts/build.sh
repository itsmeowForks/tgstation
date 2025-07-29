#!/bin/bash

cd $SCRIPT_ROOT/libs/rust

if [ -f "/etc/debian_version" ]; then
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install zlib1g-dev:i386
fi

curl https://sh.rustup.rs -sSf | sh -s -- -y

source "$HOME/.cargo/env"

if ! rustup target list --installed | grep "$TARGET"; then
    rustup target add $TARGET
fi

git clone --depth 1 --branch $LIBRARY_VERSION $LIBRARY_GIT $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/repository

cd $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/repository

if [[ $NATIVE_BUILD == "yes" ]]; then
    RUSTFLAGS="-C target-cpu=native"
else
    export PKG_CONFIG_ALLOW_CROSS=1
fi
cargo build --release --target $TARGET $(echo $LIBRARY_BUILD_ARGS) $(echo $ADDITIONAL_LIBRARY_BUILD_ARGS)

export $EXECUTABLE_PATH=$SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/repository/target/$TARGET/release/$EXECUTABLE_NAME

cd $SCRIPT_ROOT
