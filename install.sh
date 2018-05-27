#!/bin/sh
#set -x
set -e
echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

echo "Install SDKMAN..."
curl -fsSL https://get.sdkman.io | bash

echo "Install PIP et al..."
sudo easy_install pip
pip install virtualenv

echo "Install Go..."
mkdir $HOME/Go
mkdir -p $home/Go/src/github.com/smclernon

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null

cp zshrc ~/.zshrc
source ~/.zshrc

# Config antigen
curl -L git.io/antigen > $HOME/antigen.zsh

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir -p $HOME/Sites

# Symlink the Mackup config file to the home directory
#ln -s ./.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
