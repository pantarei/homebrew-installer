#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d`

# Clone repo into temp folder.
cd $TMP_DIR
git clone --recursive --branch $BRANCH https://github.com/pantarei/homebrew-installer.git

# Install XCode
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Install Homebrew Cask
brew install caskroom/cask/brew-cask

# brew tap
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
