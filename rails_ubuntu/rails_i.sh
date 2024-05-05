#!/bin/bash

# Function to display task status
task_status() {
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] $1"
    else
        echo "[FAILED] $1"
    fi
}

# Update system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y
task_status "System update"

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison \
build-essential libyaml-dev libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev \
libtool pkg-config sqlite3 nodejs npm
task_status "Dependency installation"

# Install rbenv
echo "Installing rbenv..."
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
task_status "rbenv installation"

# Install ruby-build
echo "Installing ruby-build..."
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
task_status "ruby-build installation"

# Install Ruby
echo "Installing Ruby 3.1.0..."
rbenv install 3.1.0
rbenv global 3.1.0
task_status "Ruby installation"

# Install Rails
echo "Installing Rails..."
gem install rails
task_status "Rails installation"

# Verify installation
echo "Verifying installation..."
ruby -v
rails -v
task_status "Verification"

echo "Installation completed."
