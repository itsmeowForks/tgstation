#/bin/bash

if [[ -f $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/pre_install.sh ]]; then
    source $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/pre_install.sh
fi

mkdir -p ~/.byond/bin
cp $EXECTUABLE_PATH ~/.byond/bin/$EXECUTABLE_NAME
chmod +x ~/.byond/bin/$EXECUTABLE_NAME
ldd ~/.byond/bin/$EXECUTABLE_NAME

if [[ -f $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/post_install.sh ]]; then
    source $SCRIPT_ROOT/libs/rust/$LIBRARY_NAME/post_install.sh
fi
