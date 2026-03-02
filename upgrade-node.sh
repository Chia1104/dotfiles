#!/bin/bash

# Load NVM command so that it is recognized in the script
. $HOME/.nvm/nvm.sh

if [ $# -eq 0 ]; then
    echo "Error: You must pass the Node.js version to upgrade as an argument E.g.: v24.14.0"
    exit 1
fi

current_version=$( node -v )

nvm_global_libs_folder="$HOME/.nvm/versions/node/$current_version/lib/node_modules"

global_lib_folders=()

for subfolder in "$nvm_global_libs_folder"/*; do
    if [ -d "$subfolder" ]; then
        subfolder_name=$(basename "$subfolder")
        global_lib_folders+=("$subfolder_name")
    fi
done

new_node_version=$1

echo "Upgrading from node $current_version to $new_node_version"

nvm install $new_node_version

if [ $? -ne 0 ]; then
  exit 1
fi

nvm alias default $new_node_version

node -v

echo "Installing global node modules..."

npm install -g "${global_lib_folders[@]}"

echo "Node.js has been upgraded successfully!"
