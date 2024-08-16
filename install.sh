#!/bin/bash
# Installation for Unix/Linux

installation_path="/usr/local"
bin_path="${installation_path}/bin"
share_path="${installation_path}/share"
DIR="$(dirname "$(realpath "$0")")"

# Remove symbolic link if exists
sudo rm -f "${bin_path}/devstarter"

sudo mkdir -p "${share_path}/devstarter"
sudo mkdir -p "${share_path}/devstarter/templates"
sudo mkdir -p "${share_path}/devstarter/src"

if [ -d "$DIR/templates" ]; then
    sudo cp -r "$DIR/templates" "${share_path}/devstarter"
else
    echo "Error: missing templates/ directory"
    exit 1
fi

if [ -d "$DIR/src" ]; then
    sudo cp -r "$DIR/src" "${share_path}/devstarter"
else
    echo "Error: missing src/ directory"
    exit 1share_path
fi

if [ -f "$DIR/defs.sh" ]; then
    sudo cp "$DIR/defs.sh" "${share_path}/devstarter/"
else
    echo "Error: missing defs.sh file"
    exit 1
fi

if [ -f "$DIR/devstarter.sh" ]; then
    sudo cp "$DIR/devstarter.sh" "${share_path}/devstarter/"
else
    echo "Error: missing devstarter.sh file"
    exit 1
fi
# Create symbolic link
sudo ln -s /usr/local/share/devstarter/devstarter.sh /usr/local/bin/devstarter
chmod +x /usr/local/bin/devstarter

echo "Devstarter installed without errors"