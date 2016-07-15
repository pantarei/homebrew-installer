#!/bin/bash

set -o xtrace

# Define variables.
BRANCH="master"
PWD=`pwd`

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

# Patch homebrew-cask for sierra.
cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask"
cat << EOF | patch -p1
diff --git a/lib/hbc/container/zip.rb b/lib/hbc/container/zip.rb
index 8118f9c..a8f26d7 100644
--- a/lib/hbc/container/zip.rb
+++ b/lib/hbc/container/zip.rb
@@ -3 +3 @@ class Hbc::Container::Zip < Hbc::Container::Base
-    criteria.file.include? "compressed-encoding=application/zip;"
+    criteria.file.include? "application/zip;"
EOF

# Install dep packages.
brew install wget git curl coreutils
brew cask install xquartz
brew install php70 --without-apache

# Copy .bash_profile.
cp $PWD/.bash_profile $HOME/
source $HOME/.bash_profile

# Install packages.
brew cask uninstall --force adobe-reader blender
cat $PWD/homebrew.list | xargs brew install --force -
cat $PWD/homebrew-cask.list | xargs brew cask install --force -
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
