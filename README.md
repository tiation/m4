# macOS M4 Development Environment Setup

<div align="center">

![Tiation Ecosystem](https://img.shields.io/badge/🔮_TIATION_ECOSYSTEM-tiation_m4_project-00FFFF?style=for-the-badge&labelColor=0A0A0A&color=00FFFF)

**Enterprise-grade solution in the Tiation ecosystem**

*Professional • Scalable • Mission-Driven*

[![🌐_Live_Demo](https://img.shields.io/badge/🌐_Live_Demo-View_Project-00FFFF?style=flat-square&labelColor=0A0A0A)](https://github.com/tiation/tiation-m4-project)
[![📚_Documentation](https://img.shields.io/badge/📚_Documentation-Complete-007FFF?style=flat-square&labelColor=0A0A0A)](https://github.com/tiation/tiation-m4-project)
[![⚡_Status](https://img.shields.io/badge/⚡_Status-Active_Development-FF00FF?style=flat-square&labelColor=0A0A0A)](https://github.com/tiation/tiation-m4-project)
[![📄_License](https://img.shields.io/badge/📄_License-MIT-00FFFF?style=flat-square&labelColor=0A0A0A)](https://github.com/tiation/tiation-m4-project)

</div>

---
**Apple MacBook Air M4 • 16 GB RAM (2025)**  
*Flutter · Dart · Python · Java · C#/.NET · JavaScript (Node/React/Angular) · Kubernetes · Selenium · AI*

---

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd m4

# Run the master setup script
chmod +x scripts/setup_master.sh
./scripts/setup_master.sh

# Or run individual scripts
./scripts/01_system_prefs.sh
./scripts/02_package_mgmt.sh
# ... and so on
```

---

## 📁 Repository Structure

```
m4/
├── scripts/                     # Modular setup scripts
│   ├── 01_system_prefs.sh      # System preferences configuration
│   ├── 02_package_mgmt.sh      # Homebrew and package management
│   ├── 03_dev_env.sh          # Developer environment setup
│   ├── 04_mobile_dev.sh       # Mobile development (Flutter, Android, iOS)
│   ├── 05_cloud_devops.sh     # Cloud and DevOps tools
│   ├── 06_workspace_setup.sh  # Workspace directory structure
│   ├── 07_startup_launcher.sh # Development environment launcher
│   └── setup_master.sh        # Master orchestration script
├── docs/                       # Documentation
├── .gitignore                  # Git ignore rules
├── LICENSE                     # MIT License
├── CONTRIBUTING.md             # Contribution guidelines
├── CODE_OF_CONDUCT.md         # Code of conduct
└── README.md                  # This file
```

---

## ⚙️ Script Modules

### 1. System Preferences (`01_system_prefs.sh`)
- Dark mode configuration
- Dock and Finder optimizations
- Rosetta 2 installation
- Xcode command-line tools

### 2. Package Management (`02_package_mgmt.sh`)
- Homebrew installation
- Essential GUI applications
- Developer command-line tools
- Development environments
- Developer fonts

### 3. Developer Environment (`03_dev_env.sh`)
- Oh My Zsh setup
- Git configuration
- SSH key generation
- Node.js and npm setup

### 4. Mobile Development (`04_mobile_dev.sh`)
- Flutter environment configuration
- Android SDK setup
- iOS development environment
- Python AI development environment

### 5. Cloud & DevOps (`05_cloud_devops.sh`)
- Kubernetes tools (kubectl, helm, k9s, minikube)
- Cloud CLI tools (AWS, Azure, GCP)
- Docker environment setup
- AI/ML development tools
- Monitoring and debugging tools

### 6. Workspace Setup (`06_workspace_setup.sh`)
- Organized directory structure following the `/workspace` convention
- Shell environment variables and aliases
- Git ignore templates
- README templates

### 7. Startup Launcher (`07_startup_launcher.sh`)
- Quick development environment launch
- Application startup automation
- Environment status checking
- Convenient aliases

---

## 📚 Philosophy

- **Portability:** Everything via Homebrew or scripts—no manual PKGs
- **Reproducibility:** Dotfiles + `brew bundle` committed to Git
- **Minimal surface:** macOS tweaks to cut cruft, JPG screenshots
- **Legacy bridge:** Rosetta 2 for x86 tools that Flutter still needs
- **Document or die:** Each command logged; no tribal knowledge
- **Modular design:** Each script handles a specific domain
- **Workspace conventions:** Organized directory structure following the user's rules

---

## 📋 Workspace Convention

The scripts establish a workspace structure that follows the conventions from the user's rules:

```
~/workspace/
├── 00_org/          # Brand assets, onboarding docs, templates
├── 10_projects/     # Code, websites, ML notebooks
├── 20_assets/       # Photos, videos, design files
├── 30_docs/         # Strategy, documentation, legal
├── 40_ops/          # Infrastructure-as-code, scripts, backups
├── 70_data/         # Datasets, model weights
└── 99_tmp/          # Scratch space (auto-purged weekly)
```

**Environment Variables:**
- `WORKSPACE=~/workspace`
- Aliases: `ws`, `proj`, `assets`, `docs`, `ops`, `data`, `tmp`

---

## 🛠️ Usage

### Interactive Mode
```bash
./scripts/setup_master.sh
# Follow the interactive menu
```

### Full Automated Setup
```bash
./scripts/setup_master.sh --full
```

### Individual Scripts
```bash
# Run specific setup modules
./scripts/01_system_prefs.sh
./scripts/02_package_mgmt.sh
# etc.
```

### Quick Development Launch
```bash
# After setup, use the launcher
start-dev  # Opens apps, starts services, activates environments
```

---

## 💻 What Gets Installed

### GUI Applications
- **Terminals:** Warp, iTerm2
- **Browsers:** Chrome, Firefox, Brave
- **Development:** VS Code, Android Studio
- **Communication:** Slack, Discord, Signal
- **Utilities:** Raycast, Rectangle, Bitwarden
- **Media:** VLC, Figma
- **DevOps:** Docker Desktop

### Command Line Tools
- **Core:** git, wget, exa, fzf, starship
- **Languages:** nvm, yarn, pnpm, python@3.11
- **Cloud:** kubectl, helm, k9s, awscli, azure-cli
- **Mobile:** Flutter, CocoaPods
- **AI/ML:** cmake, localai, transformers

### Development Environments
- Node.js (latest LTS via nvm)
- Python 3.11 with AI packages
- Flutter with iOS/Android support
- Docker and Kubernetes
- Git with SSH keys

---

## 🔒 Security Features

- SSH key generation for GitHub/GitLab
- Environment variable management
- Secure .gitignore templates
- 1Password integration ready (as per user's workflows)
- No hardcoded secrets in scripts

---

## 📝 Documentation

- Each script is self-documenting with clear functions
- Comprehensive error handling and user feedback
- Modular design allows for easy customization
- Templates provided for common development tasks

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Code style and structure
- Testing procedures
- Pull request process
- Issue reporting

---

## 📜 License

MIT License - see [LICENSE](LICENSE) for details

---

## 🚑 Support

For issues, questions, or contributions:
1. Check the documentation in the `docs/` directory
2. Review existing issues on GitHub
3. Create a new issue with detailed information
4. Follow the code of conduct in [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

---

**Happy coding on your M4! 🎉**

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

---

## 🔮 Tiation Ecosystem

This repository is part of the Tiation ecosystem. Explore related projects:

- [🌟 TiaAstor](https://github.com/TiaAstor/TiaAstor) - Personal brand and story
- [🐰 ChaseWhiteRabbit NGO](https://github.com/tiation/tiation-chase-white-rabbit-ngo) - Social impact initiatives
- [🏗️ Infrastructure](https://github.com/tiation/tiation-rigger-infrastructure) - Enterprise infrastructure
- [🤖 AI Agents](https://github.com/tiation/tiation-ai-agents) - Intelligent automation
- [📝 CMS](https://github.com/tiation/tiation-cms) - Content management system
- [⚡ Terminal Workflows](https://github.com/tiation/tiation-terminal-workflows) - Developer tools

---
*Built with 💜 by the Tiation team*