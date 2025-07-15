#!/bin/bash

# Mobile Development Setup Script - Flutter, Android, iOS
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_flutter() {
  echo "Configuring Flutter environment..."
  flutter config --enable-ios
  flutter config --enable-android
  flutter config --enable-macos-desktop
  flutter doctor
  echo "Flutter environment configured."
}

setup_android_environment() {
  echo "Setting up Android SDK environment..."
  mkdir -p ~/Library/Android/sdk/cmdline-tools
  cd ~/Library/Android/sdk/cmdline-tools
  
  # Download Android command line tools
  curl -O https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip
  unzip commandlinetools-mac-10406996_latest.zip
  mv cmdline-tools latest
  rm commandlinetools-mac-10406996_latest.zip
  
  # Set environment variables
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  
  # Add to shell profile
  echo "export ANDROID_HOME=$HOME/Library/Android/sdk" >> ~/.zshrc
  echo "export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.zshrc
  
  flutter doctor --android-licenses
  echo "Android SDK environment configured."
}

setup_ios_environment() {
  echo "Setting up iOS development environment..."
  # Install CocoaPods if not already installed
  if ! command -v pod &> /dev/null; then
    sudo gem install cocoapods
  fi
  
  pod setup
  echo "iOS development environment configured."
}

setup_python_environment() {
  echo "Setting up Python environment for AI development..."
  brew install python@3.11
  python3.11 -m ensurepip --upgrade
  python3.11 -m pip install --upgrade pip
  python3.11 -m venv ~/ai-dev
  source ~/ai-dev/bin/activate
  pip install numpy pandas scipy matplotlib jupyter torch torchvision tensorflow-macos transformers datasets
  echo "Python AI environment configured."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "📱 Mobile Development Setup"
  confirm "Setup Flutter environment?" && setup_flutter
  confirm "Setup Android SDK environment?" && setup_android_environment
  confirm "Setup iOS development environment?" && setup_ios_environment
  confirm "Setup Python environment for AI development?" && setup_python_environment
  echo "✅ Mobile development setup complete!"
fi
