#!/bin/bash

# Master Setup Script for macOS M4 Development Environment
# Orchestrates all modular setup scripts

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

print_header() {
  echo -e "${BLUE}" 
  echo "╔════════════════════════════════════════════════════════════════════════════════╗"
  echo "║                    macOS M4 Development Environment Setup                     ║"
  echo "║                           Master Configuration Script                         ║"
  echo "╚════════════════════════════════════════════════════════════════════════════════╝"
  echo -e "${NC}"
}

print_section() {
  echo -e "${YELLOW}\n=== $1 ===${NC}"
}

print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
  echo -e "${RED}❌ $1${NC}"
}

run_script() {
  local script_name=$1
  local script_path="scripts/$script_name"
  
  if [[ -f "$script_path" ]]; then
    echo -e "${BLUE}Running: $script_name${NC}"
    chmod +x "$script_path"
    bash "$script_path"
    if [[ $? -eq 0 ]]; then
      print_success "$script_name completed successfully"
    else
      print_error "$script_name failed"
      return 1
    fi
  else
    print_error "Script not found: $script_path"
    return 1
  fi
}

show_menu() {
  echo -e "${BLUE}\nSetup Options:${NC}"
  echo "1. System Preferences Configuration"
  echo "2. Package Management (Homebrew & Apps)"
  echo "3. Developer Environment Setup"
  echo "4. Mobile Development Setup"
  echo "5. Cloud & DevOps Setup"
  echo "6. Workspace Directory Setup"
  echo "7. Startup Launcher Setup"
  echo "8. Run All Scripts (Full Setup)"
  echo "9. Exit"
  echo ""
}

run_full_setup() {
  print_section "Starting Full macOS M4 Development Setup"
  
  local scripts=(
    "01_system_prefs.sh"
    "02_package_mgmt.sh"
    "03_dev_env.sh"
    "04_mobile_dev.sh"
    "05_cloud_devops.sh"
    "06_workspace_setup.sh"
    "07_startup_launcher.sh"
  )
  
  for script in "${scripts[@]}"; do
    print_section "Running $script"
    if confirm "Execute $script?"; then
      run_script "$script"
    else
      echo "Skipping $script"
    fi
  done
  
  print_success "Full setup completed!"
}

show_summary() {
  echo -e "${GREEN}\n╔════════════════════════════════════════════════════════════════════════════════╗"
  echo "║                              Setup Complete!                                  ║"
  echo "╚════════════════════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Your macOS M4 development environment is now configured."
  echo ""
  echo "Next steps:"
  echo "• Restart your terminal to apply shell changes"
  echo "• Run 'start-dev' to launch your development environment"
  echo "• Navigate to ~/workspace to begin your projects"
  echo "• Review the README.md files in each directory"
  echo ""
  echo "For support, refer to the documentation in the docs/ directory."
}

# Main execution
main() {
  print_header
  
  # Check if we're in the right directory
  if [[ ! -d "scripts" ]]; then
    print_error "Scripts directory not found. Please run from the repository root."
    exit 1
  fi
  
  # Check for required tools
  if ! command -v curl &> /dev/null; then
    print_error "curl is required but not installed. Please install curl first."
    exit 1
  fi
  
  # Interactive menu or command line arguments
  if [[ $# -eq 0 ]]; then
    while true; do
      show_menu
      read -p "Choose an option (1-9): " choice
      case $choice in
        1) run_script "01_system_prefs.sh" ;;
        2) run_script "02_package_mgmt.sh" ;;
        3) run_script "03_dev_env.sh" ;;
        4) run_script "04_mobile_dev.sh" ;;
        5) run_script "05_cloud_devops.sh" ;;
        6) run_script "06_workspace_setup.sh" ;;
        7) run_script "07_startup_launcher.sh" ;;
        8) run_full_setup ;;
        9) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Please choose 1-9." ;;
      esac
    done
  else
    # Handle command line arguments
    case $1 in
      --full) run_full_setup ;;
      --help) 
        echo "Usage: $0 [--full|--help]"
        echo "  --full: Run all setup scripts"
        echo "  --help: Show this help message"
        echo "  (no args): Interactive menu"
        ;;
      *) echo "Unknown option: $1. Use --help for usage information." ;;
    esac
  fi
  
  show_summary
}

# Run main function
main "$@"
