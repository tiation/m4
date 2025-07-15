# MacBook Pro M4 Setup Guide

This guide provides a step-by-step setup for a development environment on the Apple MacBook Pro M4 with 48GB RAM.

## Why the Bigger Machine?

The 48GB RAM ensures smooth operations for Docker, Android/iOS emulators, and local AI workloads.

---

## Philosophy Before You Install

- **Portability:** Use Homebrew for installations, avoid manual PKGs.
- **Reproducibility:** Keep dotfiles and brew files in Git.
- **Minimal surface:** Optimize macOS, use JPG for screenshots.
- **Legacy bridge:** Utilize Rosetta 2 for x86 tools.
- **Documentation:** Log every command.

---

## Day‑Zero Actions

1. **Update macOS:** `  > Settings > General > Software Update`
2. **Install Chrome:** `brew install --cask google-chrome`
3. **Xcode CLI tools:** `xcode-select --install` and `sudo xcodebuild -runFirstLaunch`
4. **Rosetta 2:** `sudo softwareupdate --install-rosetta --agree-to-license`
5. **Install Homebrew:**
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
6. **Switch to Bash (optional):** `chsh -s /bin/bash`

---

## Core Packages and Tools

```bash
# Utilities and shell enhancements
brew install git exa starship fzf wget cmatrix vips

# Runtime managers
brew install nvm pnpm pyenv rbenv

# Languages / SDKs
brew install --cask flutter dart dotnet-sdk temurin
brew install python@3.11

# Editors / IDEs
brew install --cask warp visual-studio-code android-studio

# Containers and k8s
brew install --cask docker
brew install kubectl helm k9s kubectx minikube talosctl

# Cloud CLI tools
brew install awscli azure-cli --cask google-cloud-sdk

# Browsers and test drivers
brew install --cask firefox brave-browser chromedriver selenium-server
```

---

## System Preferences Tweaks

- **Appearance:** Dark Mode, show scrollbars always.
- **Dock:** Auto-hide, remove recent apps, enable indicators.
- **Finder:** Show all filename extensions, add Library to Favourites.
- **Trackpad:** Enable Tap-to-Click, disable certain gestures.
- **Security:** Enable FileVault, add browsers to Screen Recording.
- **Terminal Commands:**
  ```bash
  defaults write com.apple.screencapture type jpg
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES
  chflags nohidden ~/Library
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  killall Finder
  ```

---

## Development Directory Layout

```bash
mkdir -p ~/Projects/{web,flutter,backend,k8s,infra,scripts}
mkdir -p ~/ai-projects/{models,datasets,checkpoints,logs}
mkdir -p ~/.local/bin ~/.cache ~/.config
```

---

## Language Quick Starts

### Node.js

```bash
nvm install --lts
npm i -g yarn pnpm commitizen
```

### Python AI Environment

```bash
pyenv install 3.11.9 && pyenv global 3.11.9
python -m pip install --upgrade pip virtualenv
virtualenv ~/ai-dev && source ~/ai-dev/bin/activate
pip install numpy pandas scipy matplotlib torch tensorflow-macos jupyterlab
```

### Flutter

```bash
flutter config --enable-ios --enable-android --enable-macos-desktop
flutter doctor --android-licenses
```

---

## Security Keys Setup

```bash
ssh-keygen -t ed25519 -C "you@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub   # To paste in GitHub/GitLab
```

---

## Final Thoughts

You now have a reproducible, full‑stack workstation setup. Happy coding! 🚀
