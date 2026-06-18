#!/bin/bash

OS_TYPE=$( uname -s )
echo "Current OS is..."

case "$OS_TYPE" in
    *CYGWIN*|*MINGW*|*MSYS*|*NT*)
        win=$(powershell.exe -Command "Get-CimInstance Win32_OperatingSystem.Caption.Trim()")
        echo "$win"

        if [ -n "%Appdata" ]; then
            TARGET_DIR=~/Appdata/Aseprite/extensions/
        else
            TARGET_DIR=~/Appdata/Roaming/Aseprite/extensions/
        fi
    ;;

    Linux*)
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            echo "$NAME"
        else
            echo "$OS_TYPE"
        fi

        TARGET_DIR=~/.config/aseprite/extensions/
    ;;

    Darwin*)
        os_name=$(sw_vers -productName)
        os_vers=$(sw_vers -productVersion)
        echo "$os_name $os_vers"

        TARGET_DIR=~/Library/"Application Support"/Aseprite/extensions/
    ;;

    *)
        echo "Unsupport OS, quitting..."
        exit 1
    ;;
esac

echo "Copying extension to \"$TARGET_DIR\"..."
if [ ! -d "$TARGET_DIR" ]; then
    echo "There is no \"$TARGET_DIR\", quitting..."
    exit 1
fi

sudo cp -r ../matrix_for_aseprite $TARGET_DIR
if [ $? -eq 0 ]; then
    echo "Done!"
else
    echo "Failed, may be permission issue"
fi