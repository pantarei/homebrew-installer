#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d -t homebrew-installer.XXXXXX`

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew update && brew upgrade && brew doctor

# Install dep packages.
brew install wget git curl coreutils
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Install Homebrew Cask.
brew install caskroom/cask/brew-cask
brew update && brew upgrade && brew doctor

# Install Homebrew-PHP.
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew update && brew upgrade && brew doctor
brew install php56

# Install Caskroom-fonts.
brew tap caskroom/fonts

# Clone repo into temp folder.
git clone https://github.com/pantarei/homebrew-installer.git $TMP_DIR

# Copy .bash_profile.
cp $TMP_DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
cat $TMP_DIR/homebrew.list | xargs brew install --force -
cat $TMP_DIR/homebrew-cask.list | xargs brew cask install --force -

# Post-install cleanup
sudo /bin/cp -RfX /usr/local/opt/osxfuse/Library/Filesystems/osxfusefs.fs /Library/Filesystems
sudo chmod +s /Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs
rm ~/Library/Application\ Support/Dock/*.db && killall Dock
