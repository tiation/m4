## End‑to‑End Setup Guide

**Apple MacBook Air M4 • 16 GB RAM (2025)**
*Flutter · Dart · Python · Java · C#/.NET · JavaScript (Node/React/Angular) · Kubernetes · Selenium · AI*

---

### 2  Philosophy Before You Install

* **Portability:** Everything via Homebrew or scripts—no manual PKGs.
* **Reproducibility:** Dotfiles + `brew bundle` committed to Git.
* **Minimal surface:** macOS tweaks to cut cruft, JPG screenshots.
* **Legacy bridge:** Rosetta 2 for x86 tools that Flutter still needs.
* **Document or die:** Each command logged; no tribal knowledge.

---

### 3  Day‑Zero Actions

| Step                      | Command / Action                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------- |
| Update macOS              | `  > Settings > General > Software Update`                                                       |
| Install Chrome            | `brew install --cask google-chrome`                                                               |
| Xcode CLI tools           | `xcode-select --install` → `sudo xcodebuild -runFirstLaunch`                                      |
| Rosetta 2                 | `sudo softwareupdate --install-rosetta --agree-to-license`                                        |
| Homebrew                  | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| (Optional) switch to Bash | `chsh -s /bin/bash`                                                                               |

---

### 4  Core Packages

```bash
# Utilities & shell candy
brew install git exa starship fzf wget cmatrix vips

# Runtime managers
brew install nvm pnpm pyenv rbenv

# Languages / SDKs
brew install --cask flutter dart dotnet-sdk temurin
brew install python@3.11

# Editors / IDEs
brew install --cask warp visual-studio-code android-studio

# Containers & k8s
brew install --cask docker
brew install kubectl helm k9s kubectx minikube talosctl

# Cloud CLIs
brew install awscli azure-cli --cask google-cloud-sdk

# Browsers & test drivers
brew install --cask firefox brave-browser chromedriver selenium-server
```

---

### 5  System Preferences Tweaks

* **Appearance:** Dark Mode, *Show scrollbars ▶ Always*.
* **Dock:** Auto‑hide, small size, recent apps OFF, indicators ON.
* **Finder:** Show all filename extensions, hide desktop icons, add **Library** to Favourites, *Remove items from Bin after 30 days*.
* **Trackpad:** Tap‑to‑Click, disable Look‑up/Data‑detectors & Notification‑Center gesture, max speed.
* **Keyboard:** Kill smart quotes/auto‑caps; FN key ▶ Do Nothing; disable Spotlight shortcut (Raycast replaces it).
* **Security:** FileVault ON; add browser to *Screen Recording*.
* **Storage:** Delete GarageBand & iMovie.
* **Terminal defaults:**

  ```bash
  defaults write com.apple.screencapture type jpg        # smaller shots
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES
  chflags nohidden ~/Library
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  killall Finder
  ```

---

### 6  Directory Layout

```bash
mkdir -p ~/Projects/{web,flutter,backend,k8s,infra,scripts}
mkdir -p ~/ai-projects/{models,datasets,checkpoints,logs}
mkdir -p ~/.local/bin ~/.cache ~/.config
```

---

### 7  Shell Profiles (`~/.bash_profile` & `~/.zshrc`)

* PATH prepends `~/.local/bin`.
* History 100 k lines; dedup ON.
* `fzf` bound to **Ctrl‑R** for reverse‑search.
* Shared aliases:
  `ll` → `exa -al --icons`, `gs|ga|gc|gp`, `kctx`, `kns`.
* NVM bootstrap:

  ```bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \\. "$(brew --prefix)/opt/nvm/nvm.sh"
  ```
* Starship prompt if installed.

---

### 8  Language Quick Starts

```bash
# Node (latest LTS)
nvm install --lts
npm i -g yarn pnpm commitizen

# Python AI env
pyenv install 3.11.9 && pyenv global 3.11.9
python -m pip install --upgrade pip virtualenv
virtualenv ~/ai-dev && source ~/ai-dev/bin/activate
pip install numpy pandas scipy matplotlib torch tensorflow-macos jupyterlab

# Flutter
flutter config --enable-ios --enable-android --enable-macos-desktop
flutter doctor --android-licenses
```

---

### 9  Mobile Toolchains

| Platform    | Action                                                                              |
| ----------- | ----------------------------------------------------------------------------------- |
| **Android** | Android Studio → SDK Manager → Cmd‑line tools <br> Add to `PATH` → `flutter doctor` |
| **iOS**     | Accept Xcode licence → Xcode > Settings > Components (install latest Simulator)     |

---

\### 10  Containers & k8s

```bash
open -a Docker
minikube config set driver docker
minikube start
helm repo add bitnami https://charts.bitnami.com/bitnami
```

---

### 11  Cloud CLIs

```bash
aws configure       # keys, region, format
az login            # browser pops up
gcloud init         # choose project
```

---

### 12  AI / LLM Extras

```bash
brew install cmake
git clone https://github.com/ggerganov/llama.cpp && cd llama.cpp
cmake -DLLAMA_METAL=ON -B build && cmake --build build -j
pip install transformers datasets accelerate bitsandbytes optimum
brew install --cask jan      # desktop inference UI
brew install localai
```

---

### 13  Test & QA

```bash
brew install --cask postman
pip install selenium
npm i selenium-webdriver
flutter pub add webdriver
```

---

### 14  Security Keys

```bash
ssh-keygen -t ed25519 -C "you@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub   # paste to GitHub/GitLab
```

---

### 15  Validation Matrix

| Tool       | Check                                                 |        |
| ---------- | ----------------------------------------------------- | ------ |
| Flutter    | `flutter doctor -v`                                   |        |
| iOS sim    | \`xcrun simctl list                                   | head\` |
| Android    | `adb devices`                                         |        |
| .NET       | `dotnet --info`                                       |        |
| k8s        | `kubectl version --client`                            |        |
| Cloud CLIs | `aws --version` · `az --version` · `gcloud --version` |        |

---

### 16  One‑Command Launcher

`start-dev` (deployed by the bootstrap script) opens Warp, VS Code, Docker, Android Studio, Chrome, then waits for Docker and boots Minikube.

---

### 17  Accessibility & IAM Extras

* **Flutter WCAG** – use `flutter_a11y` package + Chrome DevTools’ Accessibility pane.
* **Browser tracing:** SAML‑Tracer (Chrome / Firefox).
* **VS Code** – Azure AD B2C Policy Explorer extension.

---

### 18  Virtualisation (optional)

```bash
brew install --cask vmware-fusion     # or
brew install --cask virtualbox
```

---

### 19  Done

You now have a reproducible, full‑stack workstation—without the 1990s déjà vu. Happy shipping! 🚀
