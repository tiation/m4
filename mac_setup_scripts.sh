#!/bin/bash

# Interactive macOS Setup Script for Web Developers (2025)

# Function to ask for user confirmation
confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# Update system preferences via defaults
setup_system_preferences() {
  echo "Setting up System Preferences..."

  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock tilesize -int 36
  defaults write com.apple.menuextra.battery ShowPercent YES
  defaults write com.apple.screencapture type jpg
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  chflags nohidden ~/Library
  killall Finder

  echo "System Preferences updated."
}

# Install Homebrew and packages
install_homebrew_packages() {
  echo "Installing Homebrew and packages..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew update

  brew install --cask raycast bitwarden google-chrome firefox brave-browser tor iterm2 visual-studio-code docker rectangle slack discord signal vlc calibre figma imageoptim maccy protonvpn zoom skype sequel-ace ngrok obs keycastr shotcut

  brew install wget exa git nvm yarn pnpm graphicsmagick commitizen cmatrix vips starship

  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  echo "Homebrew packages installed."
}

# Setup Oh My Zsh
setup_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

  cat << EOF >> ~/.zshrc
plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
eval "\$(starship init zsh)"
EOF

  source ~/.zshrc
  echo "Oh My Zsh configured."
}

# Configure Git
setup_git() {
  read -p "Enter your Git global user.name: " git_name
  git config --global user.name "$git_name"

  read -p "Enter your Git global user.email: " git_email
  git config --global user.email "$git_email"

  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  git config --global init.defaultBranch main

  echo "Git configuration completed."
}

# SSH Key Setup
setup_ssh() {
  mkdir -p ~/.ssh
  cd ~/.ssh

  ssh-keygen -t ed25519 -C "github" -f ~/.ssh/github

  cat << EOF >> ~/.ssh/config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github
EOF

  ssh-add --apple-use-keychain ~/.ssh/github

  echo "SSH Key created. Add the following key to your GitHub account:"
  cat ~/.ssh/github.pub | pbcopy
  echo "Public key copied to clipboard."
}

# Node and npm Setup
setup_node() {
  echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.zshrc
  source ~/.zshrc

  nvm install --lts
  npm install -g npm@latest

  read -p "Enter your npm author name: " npm_name
  npm set init-author-name="$npm_name"

  read -p "Enter your npm author email: " npm_email
  npm set init-author-email="$npm_email"

  read -p "Enter your npm author URL: " npm_url
  npm set init-author-url="$npm_url"

  echo "Node and npm setup completed."
}

# Main setup execution
main() {
  confirm "Start macOS system preferences setup?" && setup_system_preferences
  confirm "Install Homebrew packages and applications?" && install_homebrew_packages
  confirm "Setup Oh My Zsh terminal environment?" && setup_oh_my_zsh
  confirm "Configure Git?" && setup_git
  confirm "Create SSH key for GitHub?" && setup_ssh
  confirm "Install and configure Node.js and npm?" && setup_node

  echo "macOS development environment setup complete!"
}

main
