#!/bin/bash

set -o xtrace

# Install XCode.
xcode-select --install
sudo xcodebuild -license

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew update && brew upgrade && brew doctor
brew install wget git curl coreutils
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d`
REPO_DIR="$TMP_DIR/homebrew-installer"

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

# Copy .bash_profile.
cp $REPO_DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
cat $REPO_DIR/homebrew.list | xargs brew install --force -
cat $REPO_DIR/homebrew-cask.list | xargs brew cask install --force -

# Post-install cleanup
sudo /bin/cp -RfX /usr/local/opt/osxfuse/Library/Filesystems/osxfusefs.fs /Library/Filesystems
sudo chmod +s /Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs
