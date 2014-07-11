#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"

TMP_DIR=`mktemp -d`
if [ -z "$TMP_DIR" ]; then
    TMP_DIR=`mktemp -d -t ''`
fi

REPO_DIR="$TMP_DIR/homebrew-installer"

# Install XCode.
xcode-select --install
sudo xcodebuild -license

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew update && brew upgrade && brew doctor
brew install wget git curl

# Install Homebrew Cask.
brew install caskroom/cask/brew-cask
brew update && brew upgrade && brew doctor

# Install Homebrew-PHP.
brew untap homebrew/dupes 
brew untap homebrew/versions
brew untap homebrew/homebrew-php
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew update && brew upgrade && brew doctor
brew install php55

# Clone repo into temp folder.
git clone https://github.com/pantarei/homebrew-installer.git $REPO_DIR

# Install packages.
cat $REPO_DIR/homebrew.list | xargs brew install --force -
cat $REPO_DIR/homebrew-cask.list | xargs brew cask install --force -

# Copy .bash_profile.
cp $REPO_DIR/.bash_profile $HOME/

# Reset launchpad.
rm ~/Library/Application\ Support/Dock/*.db
killall Dock

# Double confirm all works.
brew update && brew upgrade && brew doctor
