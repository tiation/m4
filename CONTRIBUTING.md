# Contributing to macOS M4 Development Setup

We welcome contributions to improve the macOS M4 Development Setup scripts! This document outlines the process for contributing to this project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/m4.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes thoroughly
6. Submit a pull request

## Code Style Guidelines

### Shell Scripts
- Use `#!/bin/bash` shebang
- Use `set -euo pipefail` for error handling
- Use double quotes for variable expansion
- Use meaningful variable names
- Include comments for complex logic
- Use consistent indentation (2 spaces)

### Function Naming
- Use descriptive function names with underscores
- Prefix functions with their module name where appropriate
- Example: `setup_git()`, `install_homebrew()`

### Error Handling
- Always check command exit codes
- Provide meaningful error messages
- Use the `confirm()` function for user interactions
- Handle edge cases gracefully

## Script Structure

Each script should follow this structure:

```bash
#!/bin/bash

# Script Description
# Part of macOS M4 Development Setup Suite

confirm() {
  read -p "$1 [y/N]: " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

function_name() {
  echo "Doing something..."
  # Implementation
  echo "Done."
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "🔧 Script Name"
  confirm "Do something?" && function_name
  echo "✅ Script complete!"
fi
```

## Testing

Before submitting a pull request:

1. Test your script on a clean macOS M4 system
2. Test both interactive and non-interactive modes
3. Verify that the script can be run multiple times safely
4. Check that all dependencies are properly handled
5. Test the master script integration

## Documentation

- Update the README.md if you add new functionality
- Add comments to explain complex logic
- Update the function documentation
- Include examples where appropriate

## Submitting Changes

1. Ensure your code follows the style guidelines
2. Test your changes thoroughly
3. Update documentation as needed
4. Create a clear commit message
5. Submit a pull request with:
   - Clear description of changes
   - Reason for the change
   - Testing performed
   - Any breaking changes

## Pull Request Process

1. Ensure all tests pass
2. Update the README.md with details of changes if applicable
3. Increase version numbers in any example files and the README.md
4. Your pull request will be reviewed by maintainers
5. Address any feedback or requested changes
6. Once approved, your changes will be merged

## Issues and Bug Reports

When reporting issues:

1. Use the GitHub issue templates
2. Include your macOS version and hardware details
3. Provide steps to reproduce the issue
4. Include relevant error messages
5. Mention which script(s) are affected

## Feature Requests

For new features:

1. Check if the feature already exists
2. Explain the use case and benefits
3. Provide examples of expected behavior
4. Consider backward compatibility

## Code of Conduct

This project follows the Contributor Covenant Code of Conduct. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details.

## Questions?

If you have questions about contributing, please:

1. Check the documentation
2. Search existing issues
3. Create a new issue with the "question" label

Thank you for contributing to the macOS M4 Development Setup project!
