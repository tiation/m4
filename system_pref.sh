#!/bin/bash

# Function to ask for user confirmation
confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# Function to handle errors
handle_error() {
  echo "Error on line $1"
  exit 1
}

# Trap errors to provide error handling
trap 'handle_error $LINENO' ERR

# Setup system preferences
setup_system_preferences() {
  echo "Configuring System Preferences..."

  # Enable Dark Mode
  defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
  echo "Enabled Dark Mode."

  # Always show scroll bars
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  echo "Scroll bars always visible."

  # Dock preferences
  defaults write com.apple.dock autohide -bool true
  echo "Enabled Dock auto-hide."

  defaults write com.apple.dock tilesize -int 36
  echo "Set Dock tile size to 36."

  defaults write com.apple.dock show-recents -bool false
  echo "Disabled recent applications in Dock."

  # Finder preferences
  defaults write com.apple.finder AppleShowAllFiles YES
  echo "Finder: Show all files."

  defaults write com.apple.finder ShowPathbar -bool true
  echo "Finder: Path bar enabled."

  defaults write com.apple.finder ShowStatusBar -bool true
  echo "Finder: Status bar enabled."

  chflags nohidden ~/Library
  echo "Library folder visible."

  # Misc preferences
  defaults write com.apple.menuextra.battery ShowPercent YES
  echo "Battery percentage in menu bar."

  defaults write com.apple.screencapture type -string "jpg"
  echo "Screenshots in JPEG format."

  # Apply changes
  killall Dock
  killall Finder

  echo "System Preferences configured."
}

main() {
  confirm "Configure macOS System Preferences?" && setup_system_preferences
  echo "Setup complete!"
}

main
