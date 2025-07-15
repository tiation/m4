
---

####   Core Dev Stack (Brew)

```bash
# Version control & shells
brew install git exa starship fzf

# Languages & runtimes
brew install nvm pnpm pyenv rbenv
brew install --cask flutter dart dotnet-sdk openjdk temurin

# IDEs & editors
brew install --cask warp visual-studio-code android-studio

# Container & k8s
brew install --cask docker
brew install kubectl helm k9s kubectx minikube

# Cloud CLIs
brew install azure-cli awscli --cask google-cloud-sdk

# Browsers & testing drivers
brew install --cask firefox brave-browser
brew install --cask chromedriver selenium-server
```

---

#### 5  Language‑Specific Quick Starts

* **Node / JavaScript**

  ```bash
  nvm install --lts
  npm i -g yarn pnpm commitizen
  ```

* **Python 3.11 (AI)**

  ```bash
  pyenv install 3.11.9 && pyenv global 3.11.9
  python -m pip install --upgrade pip virtualenv
  virtualenv ~/ai-dev && source ~/ai-dev/bin/activate
  pip install numpy pandas torch tensorflow-macos jupyterlab
  ```

* **Flutter**

  ```bash
  flutter config --enable-ios --enable-android --enable-macos-desktop
  flutter doctor --android-licenses
  ```

* **.NET 8**

  ```bash
  dotnet new console -o HelloWorld
  dotnet run --project HelloWorld
  ```

---

#### 6  Android & iOS Tooling

| Platform    | Steps                                                                                                            |
| ----------- | ---------------------------------------------------------------------------------------------------------------- |
| **Android** | *Android Studio* → SDK Manager → Command‑line tools. Add to `PATH`, then `flutter doctor`.                       |
| **iOS**     | Xcode > Preferences > Components → download latest Simulator. Accept licence: `sudo xcodebuild -license accept`. |

---

#### 7  Quality‑of‑Life Tweaks

1. **System Prefs** → Appearance > Dark, Show scrollbars **Always**.
2. Dock: auto‑hide, indicators ON, recent apps OFF.
3. Finder: show all filename extensions, hide desktop icons, add *Library* to Favourites.
4. Trackpad: enable Tap‑to‑Click, kill Look‑up/Data‑detectors.
5. `defaults write com.apple.screencapture type jpg` (lighter screenshots).

---

#### 8  Security & Keys

```bash
ssh-keygen -t ed25519 -C "your.email@company.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub  # paste into GitHub, GitLab, etc.
```

---


