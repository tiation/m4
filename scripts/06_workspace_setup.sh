#!/bin/bash

# Workspace Directory Setup Script
# Part of macOS M4 Development Setup Suite
# Establishes the workspace conventions referenced in the user's rules

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_workspace_directories() {
  echo "Creating workspace directory structure..."
  
  # Create workspace root
  mkdir -p ~/workspace
  
  # Create organized subdirectories following the convention
  mkdir -p ~/workspace/00_org
  mkdir -p ~/workspace/10_projects
  mkdir -p ~/workspace/20_assets
  mkdir -p ~/workspace/30_docs
  mkdir -p ~/workspace/40_ops
  mkdir -p ~/workspace/70_data
  mkdir -p ~/workspace/99_tmp
  
  # Create project subdirectories
  mkdir -p ~/workspace/10_projects/{web,flutter,backend,k8s,infra,scripts}
  
  # Create AI-specific directories
  mkdir -p ~/workspace/70_data/{models,datasets,checkpoints,logs}
  
  # Create ops directories
  mkdir -p ~/workspace/40_ops/{ansible,docker,kubernetes,terraform,scripts}
  
  # Create docs directories
  mkdir -p ~/workspace/30_docs/{architecture,api,user-guides,legal}
  
  # Create assets directories
  mkdir -p ~/workspace/20_assets/{images,videos,audio,designs,fonts}
  
  # Create org directories
  mkdir -p ~/workspace/00_org/{brand,onboarding,templates,policies}
  
  echo "Workspace directory structure created."
}

setup_shell_environment() {
  echo "Setting up shell environment variables..."
  
  # Add WORKSPACE environment variable
  echo "export WORKSPACE=~/workspace" >> ~/.zshrc
  echo "export WORKSPACE=~/workspace" >> ~/.bash_profile
  
  # Add convenient aliases
  echo "alias ws='cd \$WORKSPACE'" >> ~/.zshrc
  echo "alias proj='cd \$WORKSPACE/10_projects'" >> ~/.zshrc
  echo "alias assets='cd \$WORKSPACE/20_assets'" >> ~/.zshrc
  echo "alias docs='cd \$WORKSPACE/30_docs'" >> ~/.zshrc
  echo "alias ops='cd \$WORKSPACE/40_ops'" >> ~/.zshrc
  echo "alias data='cd \$WORKSPACE/70_data'" >> ~/.zshrc
  echo "alias tmp='cd \$WORKSPACE/99_tmp'" >> ~/.zshrc
  
  echo "Shell environment configured."
}

setup_gitignore_templates() {
  echo "Creating .gitignore templates..."
  
  # Global gitignore for workspace
  cat > ~/workspace/.gitignore << 'EOF'
# Workspace-wide gitignore
.DS_Store
.vscode/
.idea/
*.log
*.tmp
*.cache
99_tmp/
.env
.env.local
.env.*.local
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
build/
dist/
*.egg-info/
.coverage
.pytest_cache/
.mypy_cache/
.ruff_cache/
EOF

  # Project-specific gitignore template
  cat > ~/workspace/00_org/templates/.gitignore.template << 'EOF'
# Project-specific gitignore template
.DS_Store
.vscode/
.idea/
*.log
*.tmp
.env
.env.local
node_modules/
__pycache__/
*.pyc
build/
dist/
*.egg-info/
.coverage
.pytest_cache/
EOF

  echo "Gitignore templates created."
}

setup_readme_templates() {
  echo "Creating README templates..."
  
  # Main workspace README
  cat > ~/workspace/README.md << 'EOF'
# Workspace Overview

This workspace follows an organized directory structure for development productivity.

## Directory Structure

- `00_org/` - Brand assets, onboarding docs, templates
- `10_projects/` - Code, websites, ML notebooks
- `20_assets/` - Photos, videos, design files
- `30_docs/` - Strategy, documentation, legal
- `40_ops/` - Infrastructure-as-code, scripts, backups
- `70_data/` - Datasets, model weights
- `99_tmp/` - Scratch space (auto-purged weekly)

## Getting Started

1. Use the `ws` alias to navigate to workspace root
2. Use specific aliases: `proj`, `assets`, `docs`, `ops`, `data`, `tmp`
3. Follow the naming conventions for new projects
4. Use the templates in `00_org/templates/` for new projects

## Sync Model

- Code: Git repositories
- Other files: Syncthing with 'ryzen' as introducer
EOF

  # Project README template
  cat > ~/workspace/00_org/templates/README.template.md << 'EOF'
# [Project Name]

## Description

Brief description of the project.

## Setup

1. Clone the repository
2. Install dependencies
3. Configure environment variables
4. Run the application

## Technology Stack

- Language/Framework: 
- Database: 
- Deployment: 

## Development

### Prerequisites

- Node.js/Python/etc version
- Required tools

### Installation

```bash
# Installation commands
```

### Usage

```bash
# Usage commands
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

See [LICENSE](LICENSE) for license information.
EOF

  echo "README templates created."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "📁 Workspace Setup"
  confirm "Create workspace directory structure?" && setup_workspace_directories
  confirm "Setup shell environment variables and aliases?" && setup_shell_environment
  confirm "Create gitignore templates?" && setup_gitignore_templates
  confirm "Create README templates?" && setup_readme_templates
  echo "✅ Workspace setup complete!"
fi
