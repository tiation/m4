#!/bin/bash

# Developer Environment Setup Script
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

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

setup_git() {
  echo "Configuring Git..."
  read -p "Enter your Git global user.name: " git_name
  git config --global user.name "$git_name"

  read -p "Enter your Git global user.email: " git_email
  git config --global user.email "$git_email"

  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  git config --global init.defaultBranch main

  echo "Git configuration completed."
}

setup_ssh() {
  echo "Setting up SSH..."
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

setup_node() {
  echo "Configuring Node.js and npm..."
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

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "⚙️  Developer Environment Setup"
  confirm "Setup Oh My Zsh terminal environment?" && setup_oh_my_zsh
  confirm "Configure Git?" && setup_git
  confirm "Create SSH key for GitHub?" && setup_ssh
  confirm "Install and configure Node.js and npm?" && setup_node
  echo "✅ Developer environment setup complete!"
fi
