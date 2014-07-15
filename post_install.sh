#!/bin/bash

set -o xtrace

# Reset launchpad.
rm ~/Library/Application\ Support/Dock/*.db
killall Dock

# Double confirm all works.
brew update && brew upgrade && brew doctor
