#!/bin/bash

OS_TYPE=$( uname -s )
echo "Current OS is..."

case "$OS_TYPE" in
    *CYGWIN*|*MINGW*|*MSYS*|*NT*)
        echo "Windows"
        if [ -n "%Appdata" ]; then
            TARGET_DIR=~/Appdata/Aseprite/extensions/
        else
            TARGET_DIR=~/Appdata/Roaming/Aseprite/extensions/
        fi
    ;;

    Linux*)
        echo "$OS_TYPE"
        TARGET_DIR=/.config/Aseprite/extensions/
    ;;

    Darwin*)
        echo "Macintosh"
        TARGET_DIR=~/Library/"Application Support"/Aseprite/extensions/
    ;;

    *)
        echo "Unsupport OS, quitting..."
        exit 1
    ;;
esac

if [ ! -d "$TARGET_DIR" ]; then
    echo "There is no \"$TARGET_DIR\", quitting..."
    exit 1
fi

echo "Copying extension to \"$TARGET_DIR\"..."
sudo cp -r ../matrix_for_aseprite $TARGET_DIR
if [ $? -eq 0 ]; then
    echo "Done!"
else
    echo "Failed, may be permission issue"
fi