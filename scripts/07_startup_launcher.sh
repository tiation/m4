#!/bin/bash

# Startup Launcher Script
# Part of macOS M4 Development Setup Suite
# Quickly launches development environment

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

open_essential_apps() {
  echo "Opening essential GUI applications..."
  
  # Open core development applications
  open -a "Warp" 2>/dev/null || echo "Warp not found - install via brew install --cask warp"
  open -a "Visual Studio Code" 2>/dev/null || echo "VS Code not found - install via brew install --cask visual-studio-code"
  open -a "Docker" 2>/dev/null || echo "Docker not found - install via brew install --cask docker"
  open -a "Android Studio" 2>/dev/null || echo "Android Studio not found - install via brew install --cask android-studio"
  open -a "Google Chrome" 2>/dev/null || echo "Chrome not found - install via brew install --cask google-chrome"
  
  echo "Essential applications launched."
}

start_docker_services() {
  echo "Starting Docker services..."
  
  # Start Docker Desktop and wait for it to be ready
  open --background -a Docker 2>/dev/null || echo "Docker Desktop not found"
  
  echo "Waiting for Docker to be ready..."
  local timeout=60
  local count=0
  while ! docker system info > /dev/null 2>&1; do
    if [ $count -ge $timeout ]; then
      echo "Docker failed to start within $timeout seconds"
      return 1
    fi
    echo "Docker is starting... ($count/$timeout)"
    sleep 2
    ((count+=2))
  done
  
  echo "Docker is running."
}

activate_python_env() {
  echo "Activating Python AI development environment..."
  
  if [ -f "~/ai-dev/bin/activate" ]; then
    source ~/ai-dev/bin/activate
    echo "Python AI environment activated."
  else
    echo "Python AI environment not found. Run mobile development setup first."
  fi
}

start_minikube() {
  echo "Starting Minikube Kubernetes cluster..."
  
  if command -v minikube &> /dev/null; then
    minikube start --driver=docker
    echo "Minikube Kubernetes cluster started."
  else
    echo "Minikube not found. Install via cloud/devops setup script."
  fi
}

open_development_terminals() {
  echo "Opening development terminals..."
  
  # Open Warp with multiple tabs/sessions
  osascript -e 'tell application "Warp" to activate'
  
  # Navigate to workspace
  if [ -d "~/workspace" ]; then
    cd ~/workspace
    echo "Changed to workspace directory."
  fi
  
  echo "Development terminals ready."
}

show_environment_status() {
  echo ""
  echo "=== Development Environment Status ==="
  echo "Docker: $(docker --version 2>/dev/null || echo 'Not available')"
  echo "Node: $(node --version 2>/dev/null || echo 'Not available')"
  echo "Python: $(python3 --version 2>/dev/null || echo 'Not available')"
  echo "Flutter: $(flutter --version 2>/dev/null | head -1 || echo 'Not available')"
  echo "Kubectl: $(kubectl version --client --short 2>/dev/null || echo 'Not available')"
  echo "Git: $(git --version 2>/dev/null || echo 'Not available')"
  echo ""
  echo "Current directory: $(pwd)"
  echo "Workspace: ${WORKSPACE:-'Not set'}"
  echo "===================================="
}

install_launcher_alias() {
  echo "Installing launcher alias..."
  
  # Add to shell profiles
  echo "alias start-dev='$PWD/scripts/07_startup_launcher.sh --launch'" >> ~/.zshrc
  echo "alias start-dev='$PWD/scripts/07_startup_launcher.sh --launch'" >> ~/.bash_profile
  
  echo "Launcher alias installed. Use 'start-dev' to launch development environment."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if [[ "$1" == "--launch" ]]; then
    echo "🚀 Launching Development Environment"
    open_essential_apps
    start_docker_services
    activate_python_env
    start_minikube
    open_development_terminals
    show_environment_status
    echo "✅ Development environment ready!"
  else
    echo "🚀 Startup Launcher Setup"
    confirm "Install launcher alias for quick startup?" && install_launcher_alias
    confirm "Test launch development environment now?" && {
      echo "Testing development environment launch..."
      bash "$0" --launch
    }
    echo "✅ Startup launcher setup complete!"
  fi
fi
