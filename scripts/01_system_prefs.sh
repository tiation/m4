#!/bin/bash

# System Preferences Configuration Script
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_system_preferences() {
  echo "Setting up System Preferences..."

  # Appearance & Interface
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  
  # Dock Configuration
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock tilesize -int 36
  
  # Finder Settings
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  chflags nohidden ~/Library
  
  # System Utilities
  defaults write com.apple.menuextra.battery ShowPercent YES
  defaults write com.apple.screencapture type jpg
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES
  
  # Restart affected services
  killall Finder
  killall Dock 2>/dev/null || true

  echo "System Preferences updated successfully."
}

setup_rosetta() {
  echo "Installing Rosetta for ARM compatibility..."
  softwareupdate --install-rosetta --agree-to-license
  echo "Rosetta installed successfully."
}

setup_xcode_tools() {
  echo "Installing Xcode command-line tools..."
  xcode-select --install
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
  echo "Xcode tools configured successfully."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "🛠️  macOS System Preferences Setup"
  confirm "Configure system preferences?" && setup_system_preferences
  confirm "Install Rosetta (ARM compatibility)?" && setup_rosetta
  confirm "Install and configure Xcode tools?" && setup_xcode_tools
  echo "✅ System preferences setup complete!"
fi
