#!/bin/bash

# Interactive and Comprehensive macOS Setup Script for MacBook Pro M4 Development Environment

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_system_preferences() {
  echo "Configuring detailed system preferences..."
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 32
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.screencapture type jpg
  chflags nohidden ~/Library
  killall Finder
  echo "System preferences configured."
}

install_homebrew_and_apps() {
  echo "Installing Homebrew and essential packages..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  brew install --cask warp raycast visual-studio-code iterm2 docker android-studio flutter google-chrome firefox brave-browser signal vlc figma zoom sequel-ace
  brew install git nvm kubectl helm cocoapods exa pnpm wget
  echo "Homebrew and packages installed."
}

setup_rosetta_and_xcode() {
  echo "Installing Rosetta and Xcode tools..."
  softwareupdate --install-rosetta --agree-to-license
  xcode-select --install
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
  echo "Rosetta and Xcode tools configured."
}

setup_flutter_and_android() {
  flutter config --enable-ios
  flutter config --enable-android
  flutter config --enable-macos-desktop
  mkdir -p ~/Library/Android/sdk/cmdline-tools
  cd ~/Library/Android/sdk/cmdline-tools
  curl -O https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip
  unzip commandlinetools-mac-10406996_latest.zip
  mv cmdline-tools latest
  rm commandlinetools-mac-10406996_latest.zip
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  flutter doctor --android-licenses
  echo "Flutter and Android environment configured."
}

setup_node_python_k8s() {
  mkdir ~/.nvm
  export NVM_DIR="$HOME/.nvm"
  source $(brew --prefix nvm)/nvm.sh
  nvm install --lts
  brew install python@3.11
  python3.11 -m ensurepip --upgrade
  python3.11 -m venv ~/ai-dev
  source ~/ai-dev/bin/activate
  pip install numpy pandas scipy matplotlib torch tensorflow-macos
  brew install minikube
  minikube config set driver docker
  minikube start
  echo "Node.js, Python, and Kubernetes configured."
}

setup_git_and_ssh() {
  read -p "Git user.name: " git_name
  read -p "Git user.email: " git_email
  git config --global user.name "$git_name"
  git config --global user.email "$git_email"
  git config --global core.editor "vim"
  ssh-keygen -t ed25519 -C "$git_email"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  pbcopy < ~/.ssh/id_ed25519.pub
  echo "Git and SSH keys configured. Public SSH key copied to clipboard."
}

main() {
  confirm "Configure detailed system preferences?" && setup_system_preferences
  confirm "Install Homebrew, Warp Terminal, essential GUI apps?" && install_homebrew_and_apps
  confirm "Install Rosetta and Xcode command-line tools?" && setup_rosetta_and_xcode
  confirm "Setup Flutter, Android Studio, and development tools?" && setup_flutter_and_android
  confirm "Setup Node.js, Python, and Kubernetes?" && setup_node_python_k8s
  confirm "Configure Git and generate SSH key?" && setup_git_and_ssh

  echo "Comprehensive macOS setup for MacBook Pro M4 completed!"
}

main
