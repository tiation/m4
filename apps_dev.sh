#!/bin/bash

# Interactive macOS Setup Script for Apple MacBook Pro M4 Development Environment

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_system_preferences() {
  echo "Configuring system preferences..."
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 36
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.screencapture type jpg
  killall Finder
  echo "System preferences configured."
}

install_homebrew_and_packages() {
  echo "Installing Homebrew and essential packages..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
  brew install --cask visual-studio-code android-studio docker flutter google-chrome firefox iterm2
  brew install git nvm kubectl helm k9s azure-cli awscli
  echo "Homebrew and packages installed."
}

setup_rosetta() {
  echo "Installing Rosetta for compatibility..."
  softwareupdate --install-rosetta --agree-to-license
  echo "Rosetta installed."
}

setup_git() {
  read -p "Enter your Git global user.name: " git_name
  git config --global user.name "$git_name"

  read -p "Enter your Git global user.email: " git_email
  git config --global user.email "$git_email"

  git config --global core.editor "vim"
  git config --global log.decorate auto
  git config --global diff.tool vimdiff
  git config --global merge.tool vimdiff

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
  mkdir -p ~/Library/Android/sdk/cmdline-tools
  cd ~/Library/Android/sdk/cmdline-tools
  curl -O https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip
  unzip commandlinetools-mac-10406996_latest.zip
  mv cmdline-tools latest
  rm commandlinetools-mac-10406996_latest.zip
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  flutter doctor --android-licenses
  echo "Android SDK environment set."
}

setup_node_and_nvm() {
  mkdir ~/.nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  nvm install 18
  echo "Node and nvm configured."
}

setup_kubernetes_tools() {
  brew install kubectl helm k9s kubectx minikube
  minikube config set driver docker
  minikube start
  echo "Kubernetes tools installed and configured."
}

setup_python_environment() {
  brew install python@3.11
  python3.11 -m ensurepip --upgrade
  python3.11 -m pip install --upgrade pip
  python3.11 -m venv ~/ai-dev
  source ~/ai-dev/bin/activate
  pip install numpy pandas scipy matplotlib jupyter torch torchvision tensorflow-macos transformers datasets
  echo "Python AI environment configured."
}

setup_security_and_ssh() {
  ssh-keygen -t ed25519 -C "$(git config user.email)"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  pbcopy < ~/.ssh/id_ed25519.pub
  echo "SSH key generated and public key copied to clipboard."
}

main() {
  confirm "Configure system preferences?" && setup_system_preferences
  confirm "Install Rosetta (ARM compatibility)?" && setup_rosetta
  confirm "Install Homebrew and essential dev packages?" && install_homebrew_and_packages
  confirm "Configure Git settings?" && setup_git
  confirm "Setup Flutter environment?" && setup_flutter_environment
  confirm "Setup Android SDK environment?" && setup_android_environment
  confirm "Setup Node.js and nvm?" && setup_node_and_nvm
  confirm "Setup Kubernetes tools?" && setup_kubernetes_tools
  confirm "Setup Python environment for AI development?" && setup_python_environment
  confirm "Generate SSH key for GitHub?" && setup_security_and_ssh

  echo "Apple MacBook Pro M4 development environment setup complete!"
}

main
