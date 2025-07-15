# Mac Setup Scripts Analysis and Categorization

## Overview
This document analyzes the existing Mac setup scripts and categorizes their functionalities for creating modular scripts. The analysis covers 6 script files with overlapping and complementary features.

## Scripts Analyzed
1. `mac_setup_scripts.sh` - Interactive macOS Setup Script for Web Developers (2025)
2. `mac_setup_scripts(1).sh` - MacBook Pro M4 Development Environment
3. `mac_setup_scripts(2).sh` - Optimized M4 Setup (256 GB) with Warp Terminal
4. `mac_setup_scripts(3).sh` - Comprehensive M4 Development Environment
5. `mac_setup_scripts(4).sh` - Seamless Startup Script for Development Environment
6. `mac_setup_scripts(5).sh` - ALL-IN-ONE Bootstrap Script

## Functional Categories

### 1. SYSTEM PREFERENCES & DEFAULTS
Common configurations found across scripts:

**Core System Settings:**
```bash
# Dark mode setup
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Dock configuration
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36  # variants: 32, 36
defaults write com.apple.dock show-recents -bool false

# Finder settings
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
chflags nohidden ~/Library

# Screenshot format
defaults write com.apple.screencapture type jpg

# Scroll bars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Preview settings
defaults write com.apple.Preview ApplePersistenceIgnoreState YES
```

**System Restart Commands:**
```bash
killall Finder
```

### 2. PACKAGE MANAGEMENT (HOMEBREW)
**Homebrew Installation:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
```

**GUI Applications (Casks):**
```bash
# Core Development Apps
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask warp
brew install --cask android-studio
brew install --cask iterm2

# Browsers
brew install --cask google-chrome
brew install --cask firefox
brew install --cask brave-browser
brew install --cask tor

# Communication
brew install --cask slack
brew install --cask discord
brew install --cask signal
brew install --cask zoom
brew install --cask skype

# Productivity
brew install --cask raycast
brew install --cask rectangle
brew install --cask maccy
brew install --cask figma
brew install --cask vlc
brew install --cask calibre
brew install --cask sequel-ace
brew install --cask ngrok
brew install --cask obs
brew install --cask keycastr
brew install --cask shotcut
brew install --cask bitwarden
brew install --cask protonvpn
brew install --cask imageoptim
```

**Command Line Tools:**
```bash
# Core Development
brew install git
brew install nvm
brew install wget
brew install exa
brew install pnpm
brew install yarn

# Kubernetes Tools
brew install kubectl
brew install helm
brew install k9s
brew install kubectx
brew install minikube

# Mobile Development
brew install cocoapods
brew install flutter

# Graphics & Media
brew install graphicsmagick
brew install vips

# Other Tools
brew install commitizen
brew install cmatrix
brew install starship
brew install fzf
```

**Fonts:**
```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

### 3. SYSTEM COMPATIBILITY & PREREQUISITES
**ARM/Intel Compatibility:**
```bash
# Rosetta 2 for Intel compatibility
softwareupdate --install-rosetta --agree-to-license
```

**Xcode Command Line Tools:**
```bash
xcode-select --install
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### 4. SHELL ENVIRONMENT SETUP
**Oh My Zsh Installation:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

**Shell Configuration:**
```bash
# Zsh plugins configuration
plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting fzf)

# Starship prompt
eval "$(starship init zsh)"
eval "$(starship init bash)"
```

**Environment Variables & Aliases:**
```bash
# Development paths
export DEV_ROOT="$HOME/Projects"
export AI_ROOT="$HOME/ai-projects"
export PATH="$HOME/.local/bin:$PATH"

# History settings
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoredups:erasedups

# FZF configuration
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"

# Common aliases
alias ll='exa -al --icons'
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push'
alias kctx='kubectx'
alias kns='kubens'
```

### 5. VERSION CONTROL (GIT) SETUP
**Git Configuration:**
```bash
# User setup (interactive)
read -p "Enter your Git global user.name: " git_name
git config --global user.name "$git_name"
read -p "Enter your Git global user.email: " git_email
git config --global user.email "$git_email"

# Editor and tools
git config --global core.editor "vim"
git config --global log.decorate auto
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

# Aliases and settings
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global init.defaultBranch main
```

### 6. SSH KEY MANAGEMENT
**SSH Key Generation:**
```bash
# Standard SSH key generation
ssh-keygen -t ed25519 -C "github" -f ~/.ssh/github
# or
ssh-keygen -t ed25519 -C "$(git config user.email)"

# SSH agent configuration
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# or
ssh-add --apple-use-keychain ~/.ssh/github

# SSH config
cat << EOF >> ~/.ssh/config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github
EOF

# Copy public key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub
```

### 7. DEVELOPMENT RUNTIME SETUP
**Node.js & NVM:**
```bash
# NVM setup
mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.zshrc

# Node installation
nvm install --lts
nvm install 18
npm install -g npm@latest

# NPM configuration
read -p "Enter your npm author name: " npm_name
npm set init-author-name="$npm_name"
read -p "Enter your npm author email: " npm_email
npm set init-author-email="$npm_email"
read -p "Enter your npm author URL: " npm_url
npm set init-author-url="$npm_url"
```

**Python Environment:**
```bash
# Python installation
brew install python@3.11
python3.11 -m ensurepip --upgrade
python3.11 -m pip install --upgrade pip

# Virtual environment
python3.11 -m venv ~/ai-dev
source ~/ai-dev/bin/activate

# AI/ML packages
pip install numpy pandas scipy matplotlib jupyter torch torchvision tensorflow-macos transformers datasets
```

### 8. MOBILE DEVELOPMENT SETUP
**Flutter Configuration:**
```bash
# Flutter setup
flutter config --enable-ios
flutter config --enable-android
flutter config --enable-macos-desktop
flutter doctor
flutter doctor --android-licenses
```

**Android SDK Setup:**
```bash
# Android SDK installation
mkdir -p ~/Library/Android/sdk/cmdline-tools
cd ~/Library/Android/sdk/cmdline-tools
curl -O https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip
unzip commandlinetools-mac-10406996_latest.zip
mv cmdline-tools latest
rm commandlinetools-mac-10406996_latest.zip

# Environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
```

### 9. CONTAINER & KUBERNETES SETUP
**Kubernetes Tools:**
```bash
# Tool installation
brew install kubectl helm k9s kubectx minikube

# Minikube configuration
minikube config set driver docker
minikube start
minikube start --driver=docker
```

**Docker Integration:**
```bash
# Docker startup check
while ! docker system info > /dev/null 2>&1; do
  echo "Waiting for Docker to start..."
  sleep 2
done
```

### 10. DIRECTORY STRUCTURE SETUP
**Development Directories:**
```bash
# Standard development structure
mkdir -p "$DEV_ROOT"/{web,flutter,backend,k8s,infra,scripts}
mkdir -p "$AI_ROOT"/{models,datasets,checkpoints,logs}
mkdir -p "$HOME/.local/bin" "$HOME/.cache" "$HOME/.config"

# Workspace structure (from rules)
mkdir -p ~/workspace/{00_org,10_projects,20_assets,30_docs,40_ops,70_data,99_tmp}
```

### 11. APPLICATION STARTUP AUTOMATION
**GUI Application Launcher:**
```bash
# Core development apps
open -a "Warp"
open -a "Visual Studio Code"
open -a "Docker"
open -a "Android Studio"
open -a "Google Chrome"

# Background startup
open --background -a Docker
```

**Service Startup:**
```bash
# Docker readiness check
until docker system info &>/dev/null; do
  echo "⏳ Waiting for Docker …"
  sleep 2
done

# Kubernetes cluster startup
minikube start

# Python environment activation
source ~/ai-dev/bin/activate
```

### 12. UTILITY FUNCTIONS
**Interactive Confirmation:**
```bash
# Standard confirmation function
confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# Auto-run detection
confirm() {
  [[ "$AUTO_RUN" == "--auto" ]] && return 0
  read -rp "$1 [y/N]: " ans && [[ $ans =~ ^[Yy]$ ]]
}
```

**FZF Integration:**
```bash
# FZF installation and configuration
brew install fzf
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

# Bash history search
__fzf_history() { history | sed 's/^ *[0-9]* *//' | fzf --tac; }
bind -x '"\\C-r": "BUFFER=$( __fzf_history ); CURSOR=${#BUFFER}"'
```

## Script Comparison Matrix

| Feature | Script 1 | Script 2 | Script 3 | Script 4 | Script 5 | Script 6 |
|---------|----------|----------|----------|----------|----------|----------|
| System Preferences | ✓ | ✓ | ✓ | ✗ | ✗ | ✗ |
| Homebrew Install | ✓ | ✓ | ✓ | ✗ | ✗ | ✗ |
| Oh My Zsh | ✓ | ✗ | ✗ | ✗ | ✗ | ✗ |
| Git Setup | ✓ | ✓ | ✓ | ✗ | ✗ | ✗ |
| SSH Keys | ✓ | ✓ | ✓ | ✗ | ✗ | ✗ |
| Node/NVM | ✓ | ✓ | ✓ | ✗ | ✗ | ✓ |
| Python/AI | ✗ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Flutter/Android | ✗ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Kubernetes | ✗ | ✓ | ✓ | ✓ | ✗ | ✗ |
| App Launcher | ✗ | ✗ | ✗ | ✓ | ✗ | ✓ |
| Directory Setup | ✗ | ✗ | ✗ | ✗ | ✗ | ✓ |
| Shell Profiles | ✗ | ✗ | ✗ | ✗ | ✗ | ✓ |

## Recommendations for Modular Scripts

Based on this analysis, the following modular structure is recommended:

1. **01_system_preferences.sh** - System defaults and UI preferences
2. **02_package_management.sh** - Homebrew and package installation
3. **03_development_environment.sh** - Git, SSH, shell configuration
4. **04_runtime_setup.sh** - Node, Python, language-specific setups
5. **05_mobile_development.sh** - Flutter, Android SDK setup
6. **06_container_kubernetes.sh** - Docker, Kubernetes tools
7. **07_directory_structure.sh** - Development directory creation
8. **08_application_launcher.sh** - GUI app and service startup
9. **09_shell_profiles.sh** - Bash/Zsh profile generation
10. **00_master_installer.sh** - Interactive orchestration script

Each module should include:
- Error handling and validation
- Interactive confirmation prompts
- Idempotent operations (safe to run multiple times)
- Clear success/failure feedback
- Logging capabilities
