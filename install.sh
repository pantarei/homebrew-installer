#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
TMP_DIR=`mktemp -d -t homebrew-installer.XXXXXX`

# Install Homebrew.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Uninstall Homebrew Cask.
brew uninstall --force brew-cask; brew update

# Tap all required projects.
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/completions
brew tap homebrew/dupes
brew tap homebrew/homebrew-php
brew tap homebrew/services
brew tap homebrew/versions
brew tap vitorgalvao/tiny-scripts
brew update && brew upgrade --all && brew cleanup && brew prune && brew doctor

# Install dep packages.
brew install wget git curl coreutils
brew cask install xquartz
for VERSION in php53 php54 php55 php56 php70; do
    brew unlink $VERSION
done
for VERSION in php53 php54 php55 php56 php70; do
    brew link $VERSION
    brew install $VERSION
    brew upgrade $VERSION
    for EXT in apcu intl mcrypt opcache pcntl snmp tidy uuid xdebug; do
        brew install $VERSION-$EXT
        brew upgrade $VERSION-$EXT
    done
    brew unlink $VERSION
done
brew link php70
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Clone repo into temp folder.
git clone https://github.com/pantarei/homebrew-installer.git $TMP_DIR

# Copy .bash_profile.
cp $TMP_DIR/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
brew cask uninstall --force adobe-reader blender
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
