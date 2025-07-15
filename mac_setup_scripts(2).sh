#!/bin/bash

# Optimized macOS Setup Script for Apple MacBook Pro M4 (256 GB) Development Environment Using Warp Terminal

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_system_preferences() {
  echo "Configuring essential system preferences..."
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 32
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.screencapture type jpg
  killall Finder
  echo "System preferences configured."
}

install_homebrew_and_packages() {
  echo "Installing Homebrew and essential minimal packages..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
  brew install --cask warp docker visual-studio-code flutter android-studio
  brew install git nvm kubectl helm cocoapods
  echo "Homebrew and packages installed."
}

setup_rosetta() {
  echo "Installing Rosetta for compatibility..."
  softwareupdate --install-rosetta --agree-to-license
  echo "Rosetta installed."
}

setup_xcode() {
  echo "Installing Xcode command-line tools..."
  xcode-select --install
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
  echo "Xcode tools configured."
}

setup_git() {
  read -p "Enter your Git global user.name: " git_name
  git config --global user.name "$git_name"

  read -p "Enter your Git global user.email: " git_email
  git config --global user.email "$git_email"

  git config --global core.editor "vim"
  git config --global log.decorate auto

  echo "Git configured."
}

setup_flutter_environment() {
  flutter config --enable-ios
  flutter config --enable-android
  flutter config --enable-macos-desktop
  flutter doctor
  echo "Flutter environment configured."
}

setup_android_environment() {
  echo "Configuring Android SDK..."
  mkdir -p ~/Library/Android/sdk/cmdline-tools
  cd ~/Library/Android/sdk/cmdline-tools
  curl -O https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip
  unzip commandlinetools-mac-10406996_latest.zip
  mv cmdline-tools latest
  rm commandlinetools-mac-10406996_latest.zip
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  flutter doctor --android-licenses
  echo "Android environment configured."
}

setup_node_and_nvm() {
  mkdir ~/.nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  nvm install --lts
  echo "Node.js and nvm configured."
}

setup_kubernetes_tools() {
  brew install kubectl helm minikube
  minikube config set driver docker
  minikube start
  echo "Minimal Kubernetes tools installed and configured."
}

setup_python_environment() {
  brew install python@3.11
  python3.11 -m ensurepip --upgrade
  python3.11 -m pip install --upgrade pip
  python3.11 -m venv ~/ai-dev
  source ~/ai-dev/bin/activate
  pip install numpy pandas scipy matplotlib torch tensorflow-macos
  echo "Python AI environment minimally configured."
}

setup_security_and_ssh() {
  ssh-keygen -t ed25519 -C "$(git config user.email)"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  pbcopy < ~/.ssh/id_ed25519.pub
  echo "SSH key generated and public key copied to clipboard."
}

main() {
  confirm "Configure essential system preferences?" && setup_system_preferences
  confirm "Install Rosetta (ARM compatibility)?" && setup_rosetta
  confirm "Install Homebrew and minimal dev packages including Warp Terminal, Flutter, Android Studio?" && install_homebrew_and_packages
  confirm "Install and configure Xcode tools?" && setup_xcode
  confirm "Configure Git settings?" && setup_git
  confirm "Setup minimal Flutter environment?" && setup_flutter_environment
  confirm "Setup native Android environment?" && setup_android_environment
  confirm "Setup minimal Node.js and nvm?" && setup_node_and_nvm
  confirm "Setup minimal Kubernetes tools?" && setup_kubernetes_tools
  confirm "Setup minimal Python environment for AI development?" && setup_python_environment
  confirm "Generate SSH key for GitHub?" && setup_security_and_ssh

  echo "Minimal Apple MacBook Pro M4 (256 GB) development environment setup complete!"
}

main
