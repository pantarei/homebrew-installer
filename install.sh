#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d -t homebrew-installer.XXXXXX`

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade && brew doctor

# Install Homebrew Cask.
brew install caskroom/cask/brew-cask
brew update && brew upgrade && brew doctor

# Install dep packages.
brew install wget git curl coreutils
brew cask install xquartz
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Install Homebrew-PHP.
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew update && brew upgrade && brew doctor
brew install php56

# Install Caskroom-fonts.
brew tap caskroom/fonts

# Install Homebrew-completions.
brew tap homebrew/completions

# Clone repo into temp folder.
git clone https://github.com/pantarei/homebrew-installer.git $TMP_DIR

# Copy .bash_profile.
cp $TMP_DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
cat $TMP_DIR/homebrew.list | xargs brew install --force -
cat $TMP_DIR/homebrew-cask.list | xargs brew cask install --force -

# Initialize vim, composer and npm.
bash <(curl -sL https://raw.githubusercontent.com/pantarei/vundle-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/composer-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/npm-installer/master/install.sh)

# Post-install cleanup
ln -sfv /usr/local/opt/tor/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.tor.plist
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
