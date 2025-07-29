#/bin/bash

mkdir -p ~/.byond/bin
cp $EXECTUABLE_PATH ~/.byond/bin/$EXECUTABLE_NAME
chmod +x ~/.byond/bin/$EXECUTABLE_NAME
ldd ~/.byond/bin/$EXECUTABLE_NAME
