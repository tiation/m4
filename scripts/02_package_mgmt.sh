#!/bin/bash

# Package Management Script - Homebrew and Applications
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

install_homebrew() {
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  echo "Homebrew installed successfully."
}

install_essential_apps() {
  echo "Installing essential GUI applications..."
  brew install --cask \
    warp \
    raycast \
    bitwarden \
    google-chrome \
    firefox \
    brave-browser \
    visual-studio-code \
    docker \
    rectangle \
    slack \
    discord \
    signal \
    vlc \
    figma \
    zoom \
    sequel-pro
  echo "Essential applications installed successfully."
}

install_developer_tools() {
  echo "Installing developer command-line tools..."
  brew install \
    git \
    wget \
    exa \
    nvm \
    yarn \
    pnpm \
    kubectl \
    helm \
    k9s \
    cocoapods \
    graphicsmagick \
    commitizen \
    starship \
    fzf
  echo "Developer tools installed successfully."
}

install_development_environments() {
  echo "Installing development environments..."
  brew install --cask \
    flutter \
    android-studio \
    docker
  echo "Development environments installed successfully."
}

install_fonts() {
  echo "Installing developer fonts..."
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  echo "Fonts installed successfully."
}

setup_homebrew_services() {
  echo "Setting up Homebrew services..."
  # Start essential services
  brew services start --all
  echo "Homebrew services configured."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "📦 Package Management Setup"
  
  if ! command -v brew &> /dev/null; then
    confirm "Install Homebrew package manager?" && install_homebrew
  else
    echo "Homebrew already installed, updating..."
    brew update && brew upgrade
  fi
  
  confirm "Install essential GUI applications?" && install_essential_apps
  confirm "Install developer command-line tools?" && install_developer_tools
  confirm "Install development environments (Flutter, Android Studio)?" && install_development_environments
  confirm "Install developer fonts?" && install_fonts
  confirm "Configure Homebrew services?" && setup_homebrew_services
  
  echo "✅ Package management setup complete!"
fi
