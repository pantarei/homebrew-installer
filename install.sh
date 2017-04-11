#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade && brew cleanup && brew prune && brew doctor

# Tap all required projects.
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/dupes
brew tap homebrew/homebrew-php
brew tap homebrew/services
brew tap homebrew/versions
brew tap vitorgalvao/tiny-scripts
brew update && brew upgrade && brew cleanup && brew prune && brew doctor

# Install dep packages.
brew install wget git curl coreutils
brew cask install xquartz
brew install python
brew install php70

# Copy .bash_profile.
cp $DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
cat $DIR/homebrew.list | xargs brew install --force -
cat $DIR/homebrew-cask.list | xargs brew cask install --force -
brew update && brew upgrade && brew cleanup && brew prune && brew doctor

# Initialize vim, composer and npm.
bash <(curl -sL https://raw.githubusercontent.com/pantarei/vundle-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/composer-installer/master/install.sh)
bash <(curl -sL https://raw.githubusercontent.com/pantarei/npm-installer/master/install.sh)

# Post-install cleanup
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
