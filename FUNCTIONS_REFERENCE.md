# Key Functions Reference - Extracted from Existing Scripts

## Core Utility Functions

### Interactive Confirmation
```bash
# Standard confirmation function (used in scripts 1-4)
confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# Auto-run version (script 5)
confirm() {
  [[ "$AUTO_RUN" == "--auto" ]] && return 0
  read -rp "$1 [y/N]: " ans && [[ $ans =~ ^[Yy]$ ]]
}
```

## System Configuration Functions

### System Preferences Setup
```bash
# From mac_setup_scripts.sh
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
```

### Rosetta Installation
```bash
# From mac_setup_scripts(1).sh
setup_rosetta() {
  echo "Installing Rosetta for compatibility..."
  softwareupdate --install-rosetta --agree-to-license
  echo "Rosetta installed."
}
```

### Xcode Tools Setup
```bash
# From mac_setup_scripts(2).sh
setup_xcode() {
  echo "Installing Xcode command-line tools..."
  xcode-select --install
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
  echo "Xcode tools configured."
}
```

## Package Management Functions

### Homebrew Installation
```bash
# From mac_setup_scripts.sh
install_homebrew_packages() {
  echo "Installing Homebrew and packages..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
  # Package installations...
  echo "Homebrew packages installed."
}
```

## Development Environment Functions

### Git Configuration
```bash
# From mac_setup_scripts.sh
setup_git() {
  read -p "Enter your Git global user.name: " git_name
  git config --global user.name "$git_name"
  read -p "Enter your Git global user.email: " git_email
  git config --global user.email "$git_email"
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  git config --global init.defaultBranch main
  echo "Git configuration completed."
}
```

### SSH Key Setup
```bash
# From mac_setup_scripts.sh
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
```

### Oh My Zsh Setup
```bash
# From mac_setup_scripts.sh
setup_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  
  cat << EOF >> ~/.zshrc
plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
eval "\\$(starship init zsh)"
EOF
  
  source ~/.zshrc
  echo "Oh My Zsh configured."
}
```

## Runtime Setup Functions

### Node.js and NVM
```bash
# From mac_setup_scripts.sh
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
```

### Python Environment
```bash
# From mac_setup_scripts(1).sh
setup_python_environment() {
  brew install python@3.11
  python3.11 -m ensurepip --upgrade
  python3.11 -m pip install --upgrade pip
  python3.11 -m venv ~/ai-dev
  source ~/ai-dev/bin/activate
  pip install numpy pandas scipy matplotlib jupyter torch torchvision tensorflow-macos transformers datasets
  echo "Python AI environment configured."
}
```

## Mobile Development Functions

### Flutter Environment
```bash
# From mac_setup_scripts(1).sh
setup_flutter_environment() {
  flutter config --enable-ios
  flutter config --enable-android
  flutter config --enable-macos-desktop
  flutter doctor
  echo "Flutter environment configured."
}
```

### Android SDK Setup
```bash
# From mac_setup_scripts(1).sh
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
```

## Container and Kubernetes Functions

### Kubernetes Tools
```bash
# From mac_setup_scripts(1).sh
setup_kubernetes_tools() {
  brew install kubectl helm k9s kubectx minikube
  minikube config set driver docker
  minikube start
  echo "Kubernetes tools installed and configured."
}
```

## Directory Structure Functions

### Development Directories
```bash
# From mac_setup_scripts(5).sh
setup_directories() {
  echo -e "\n▸ Creating development directory tree …"
  mkdir -p "$DEV_ROOT"/{web,flutter,backend,k8s,infra,scripts} \
            "$AI_ROOT"/{models,datasets,checkpoints,logs}
  mkdir -p "$HOME/.local/bin" "$HOME/.cache" "$HOME/.config"
  echo "✓ Directories ready."
}
```

## Shell Profile Functions

### FZF Installation
```bash
# From mac_setup_scripts(5).sh
install_fzf() {
  if ! command -v fzf >/dev/null; then
    echo "▸ Installing fzf …"
    brew install fzf >/dev/null
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
  fi
}
```

### Bash Profile Generation
```bash
# From mac_setup_scripts(5).sh
write_bash_profile() {
  cat > "$HOME/.bash_profile" <<'BASH'
# -----------------------------  ~/.bash_profile  ----------------------------
export PATH="$HOME/.local/bin:$PATH"
export DEV_ROOT="$HOME/Projects"
export AI_ROOT="$HOME/ai-projects"

# History & fzf
export HISTSIZE=100000
export HISTCONTROL=ignoredups:erasedups
export FZF_DEFAULT_OPTS="--height=${FZF_HEIGHT:-40%} --layout=reverse --border"

# Ctrl‑R history search via fzf
__fzf_history() { history | sed 's/^ *[0-9]* *//' | fzf --tac; }
bind -x '"\C-r": "BUFFER=$( __fzf_history ); CURSOR=${#BUFFER}"'

# Aliases
alias ll='exa -al --icons'
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push'
alias kctx='kubectx'
alias kns='kubens'

# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s $(brew --prefix)/opt/nvm/nvm.sh ]] && \
  source $(brew --prefix)/opt/nvm/nvm.sh

# Starship prompt (if installed)
command -v starship &>/dev/null && eval "$(starship init bash)"
# -----------------------------------------------------------------------------
BASH
}
```

## Application Launcher Functions

### GUI Application Startup
```bash
# From mac_setup_scripts(4).sh
# Open essential GUI applications
open -a "Warp"
open -a "Visual Studio Code"
open -a "Docker"
open -a "Android Studio"
open -a "Google Chrome"
```

### Service Startup with Checks
```bash
# From mac_setup_scripts(4).sh
# Start Docker Desktop and wait for it to be ready
echo "Starting Docker..."
open --background -a Docker

while ! docker system info > /dev/null 2>&1; do
  echo "Waiting for Docker to start..."
  sleep 2
done
echo "Docker is running."

# Start Minikube Kubernetes cluster
minikube start
echo "Minikube Kubernetes cluster started."
```

### Start Dev Launcher Script
```bash
# From mac_setup_scripts(5).sh
write_start_launcher() {
  cat > "$HOME/.local/bin/start-dev" <<'START'
#!/usr/bin/env bash
# Quick launcher – opens core apps & kicks services
open -ga "Warp"
open -ga "Visual Studio Code"
open -ga "Docker"
open -ga "Android Studio"
open -ga "Google Chrome"

# Wait for Docker
until docker system info &>/dev/null; do
  echo "⏳ Waiting for Docker …"; sleep 2; done

echo "🐳 Docker ready. Spinning up minikube …"
minikube start --driver=docker

echo "✅ Environment ready. Happy hacking!"
START
  chmod +x "$HOME/.local/bin/start-dev"
  echo "✓ Added launcher: start-dev"
}
```

## Main Orchestration Functions

### Standard Main Function Pattern
```bash
# From mac_setup_scripts.sh
main() {
  confirm "Start macOS system preferences setup?" && setup_system_preferences
  confirm "Install Homebrew packages and applications?" && install_homebrew_packages
  confirm "Setup Oh My Zsh terminal environment?" && setup_oh_my_zsh
  confirm "Configure Git?" && setup_git
  confirm "Create SSH key for GitHub?" && setup_ssh
  confirm "Install and configure Node.js and npm?" && setup_node
  echo "macOS development environment setup complete!"
}
```

### Bootstrap Pattern with Auto-run
```bash
# From mac_setup_scripts(5).sh
main() {
  confirm "Create directory structure under $DEV_ROOT and $AI_ROOT?" && setup_directories
  confirm "Generate Bash & Zsh profiles with fzf history/aliases?" && setup_profiles
  confirm "Install start-dev launcher script?" && write_start_launcher
  echo -e "\n🎉  Bootstrap completed.  Open a new shell or run:  exec \$SHELL -l"
}
```

This reference document provides all the key functions extracted from the existing scripts, organized by category for easy reference when creating the new modular scripts.
