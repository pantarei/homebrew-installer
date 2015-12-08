#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d -t homebrew-installer.XXXXXX`

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Install Homebrew Cask.
brew install caskroom/cask/brew-cask
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Tap all required projects.
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/completions
brew tap homebrew/dupes
brew tap homebrew/homebrew-php
brew tap homebrew/versions
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Install dep packages.
brew install php56 && brew unlink php56
brew install wget git curl coreutils php70
brew cask install xquartz
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Clone repo into temp folder.
git clone https://github.com/pantarei/homebrew-installer.git $TMP_DIR

# Copy .bash_profile.
cp $TMP_DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
cat $TMP_DIR/homebrew.list | xargs brew install --force -
cat $TMP_DIR/homebrew-cask.list | xargs brew cask install --force -
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Initialize vim, composer and npm.
bash <(curl -sL https://raw.githubusercontent.com/pantarei/vundle-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/composer-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/npm-installer/master/install.sh)

# Post-install cleanup
open /opt/homebrew-cask/Caskroom/utorrent/latest/uTorrent.app
ln -sfv /usr/local/opt/tor/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.tor.plist
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
