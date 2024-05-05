#!/bin/bash

# Function to display task status
task_status() {
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] $1"
    else
        echo "[FAILED] $1"
        exit 1
    fi
}

# Function to remove rbenv and Ruby on Rails
cleanup() {
    echo "Removing rbenv and Ruby on Rails..."
    rm -rf ~/.rbenv
    sudo apt remove --purge -y ruby rails
}

# Remove rbenv and Ruby on Rails
cleanup
task_status "Cleanup"

# Unset PATH changes
echo "Unsetting PATH changes..."
sed -i '/rbenv/d' ~/.bashrc
exec $SHELL
task_status "Unset PATH changes"

echo "Uninstallation completed."
