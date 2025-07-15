#!/bin/bash

# Cloud and DevOps Setup Script
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

setup_kubernetes_tools() {
  echo "Installing and configuring Kubernetes tools..."
  brew install kubectl helm k9s kubectx minikube
  minikube config set driver docker
  minikube start
  
  # Add useful aliases
  echo "alias k=kubectl" >> ~/.zshrc
  echo "alias kctx=kubectx" >> ~/.zshrc
  echo "alias kns=kubens" >> ~/.zshrc
  
  echo "Kubernetes tools installed and configured."
}

setup_cloud_clis() {
  echo "Installing cloud CLI tools..."
  brew install awscli azure-cli
  brew install --cask google-cloud-sdk
  
  echo "Cloud CLI tools installed. Please configure them manually:"
  echo "  - AWS: aws configure"
  echo "  - Azure: az login"
  echo "  - GCP: gcloud init"
}

setup_docker_environment() {
  echo "Configuring Docker environment..."
  # Docker Desktop should already be installed via package management
  # Start Docker Desktop
  open -a Docker
  
  # Wait for Docker to be ready
  echo "Waiting for Docker to start..."
  while ! docker system info &> /dev/null; do
    echo "Docker is starting..."
    sleep 2
  done
  
  echo "Docker is ready."
  
  # Create useful Docker aliases
  echo "alias dps='docker ps'" >> ~/.zshrc
  echo "alias dpa='docker ps -a'" >> ~/.zshrc
  echo "alias di='docker images'" >> ~/.zshrc
  echo "alias dc='docker-compose'" >> ~/.zshrc
  
  echo "Docker environment configured."
}

setup_ai_tools() {
  echo "Installing AI/ML development tools..."
  brew install cmake
  
  # Install LocalAI
  brew install localai
  
  # Install Jan (desktop AI interface)
  brew install --cask jan
  
  # Clone and build llama.cpp for local AI inference
  if [ ! -d "~/llama.cpp" ]; then
    git clone https://github.com/ggerganov/llama.cpp ~/llama.cpp
    cd ~/llama.cpp
    cmake -DLLAMA_METAL=ON -B build && cmake --build build -j
  fi
  
  echo "AI/ML tools installed."
}

setup_monitoring_tools() {
  echo "Installing monitoring and debugging tools..."
  brew install --cask keycastr
  brew install --cask ngrok
  brew install --cask postman
  
  echo "Monitoring and debugging tools installed."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "☁️  Cloud and DevOps Setup"
  confirm "Setup Kubernetes tools?" && setup_kubernetes_tools
  confirm "Install cloud CLI tools (AWS, Azure, GCP)?" && setup_cloud_clis
  confirm "Configure Docker environment?" && setup_docker_environment
  confirm "Install AI/ML development tools?" && setup_ai_tools
  confirm "Install monitoring and debugging tools?" && setup_monitoring_tools
  echo "✅ Cloud and DevOps setup complete!"
fi
