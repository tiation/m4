# ============================================================================
# MacBook Pro M4 Development Bootstrap — ALL‑IN‑ONE (interactive)
# ============================================================================
# This single script prepares user directories, installs/sources shell helpers,
# writes sane Bash ⬥ Zsh profiles (aliases, fzf history, completions) and offers
# a quick‑start launcher.  Run it step‑by‑step or unattended with ‑‑auto.
# -----------------------------------------------------------------------------
#  1. 00_dir_setup.sh          →   Creates predictable workspace + caches
#  2. 01_shell_profiles.sh     →   Generates ~/.bash_profile & ~/.zshrc
#  3. 02_start_dev.sh          →   Fires up your daily dev stack (GUI & CLI)
# -----------------------------------------------------------------------------
# Usage:
#   chmod +x mac‑bootstrap.sh
#   ./mac‑bootstrap.sh         # interactive
#   ./mac‑bootstrap.sh --auto  # run everything non‑interactively
# ============================================================================

#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# CONFIG – change to taste or export before running
# -----------------------------------------------------------------------------
DEV_ROOT="$HOME/Projects"               # where code lives
AI_ROOT="$HOME/ai-projects"             # for ML assets
FZF_HEIGHT="40%"                       # fzf pop‑up height
AUTO_RUN=${1:-""}                        # --auto skips confirmations

# -----------------------------------------------------------------------------
confirm() {
  [[ "$AUTO_RUN" == "--auto" ]] && return 0
  read -rp "$1 [y/N]: " ans && [[ $ans =~ ^[Yy]$ ]]
}

# ============================================================================
# 00 ▸ DIRECTORY LAYOUT
# ============================================================================
setup_directories() {
  echo -e "\n▸ Creating development directory tree …"
  mkdir -p "$DEV_ROOT"/{web,flutter,backend,k8s,infra,scripts} \
            "$AI_ROOT"/{models,datasets,checkpoints,logs}
  mkdir -p "$HOME/.local/bin" "$HOME/.cache" "$HOME/.config"
  echo "✓ Directories ready."
}

# ============================================================================
# 01 ▸ SHELL PROFILES  (Bash & Zsh)
# ============================================================================
install_fzf() {
  if ! command -v fzf >/dev/null; then
    echo "▸ Installing fzf …"
    brew install fzf >/dev/null
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
  fi
}

write_bash_profile() {
  cat > "$HOME/.bash_profile" <<'BASH'
# -----------------------------  ~/.bash_profile  ----------------------------
export PATH="$HOME/.local/bin:$PATH"
export DEV_ROOT="$HOME/Projects"
export AI_ROOT="$HOME/ai-projects"

# History & fzf
export HISTSIZE=100000
export HISTCONTROL=ignoredups:erasedups
export FZF_DEFAULT_OPTS="--height=${FZF_HEIGHT:-40%} --layout=reverse --border"

# Ctrl‑R history search via fzf
__fzf_history() { history | sed 's/^ *[0-9]* *//' | fzf --tac; }
bind -x '"\C-r": "BUFFER=$( __fzf_history ); CURSOR=${#BUFFER}"'

# Aliases
alias ll='exa -al --icons'
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push'
alias kctx='kubectx'
alias kns='kubens'

# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s $(brew --prefix)/opt/nvm/nvm.sh ]] && \
  source $(brew --prefix)/opt/nvm/nvm.sh

# Starship prompt (if installed)
command -v starship &>/dev/null && eval "$(starship init bash)"
# -----------------------------------------------------------------------------
BASH
}

write_zsh_profile() {
  cat > "$HOME/.zshrc" <<'ZSH'
# -------------------------------  ~/.zshrc  ---------------------------------
export PATH="$HOME/.local/bin:$PATH"
export DEV_ROOT="$HOME/Projects"
export AI_ROOT="$HOME/ai-projects"

# History & fzf (fzf-tab / key‑bindings already added by brew installer)
export HISTSIZE=100000
export SAVEHIST=100000
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
export FZF_DEFAULT_OPTS="--height=${FZF_HEIGHT:-40%} --layout=reverse --border"

# Aliases (shared with Bash for parity)
alias ll='exa -al --icons'
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push'
alias kctx='kubectx'
alias kns='kubens'

# Oh‑My‑Zsh plugins (assumes install)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)

# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s $(brew --prefix)/opt/nvm/nvm.sh ]] && \
  source $(brew --prefix)/opt/nvm/nvm.sh

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"
# -----------------------------------------------------------------------------
ZSH
}

setup_profiles() {
  echo -e "\n▸ Writing Bash & Zsh profiles …"
  install_fzf
  write_bash_profile
  write_zsh_profile
  echo "✓ Profiles saved.  Reload with:  source ~/.bash_profile  or  source ~/.zshrc"
}

# ============================================================================
# 02 ▸ START‑DEV (quick launcher)
# ============================================================================
write_start_launcher() {
  cat > "$HOME/.local/bin/start-dev" <<'START'
#!/usr/bin/env bash
# Quick launcher – opens core apps & kicks services
open -ga "Warp"
open -ga "Visual Studio Code"
open -ga "Docker"
open -ga "Android Studio"
open -ga "Google Chrome"

# Wait for Docker
until docker system info &>/dev/null; do
  echo "⏳ Waiting for Docker …"; sleep 2; done

echo "🐳 Docker ready. Spinning up minikube …"
minikube start --driver=docker

echo "✅ Environment ready. Happy hacking!"
START
  chmod +x "$HOME/.local/bin/start-dev"
  echo "✓ Added launcher: start-dev"
}

# ============================================================================
# MAIN
# ============================================================================
main() {
  confirm "Create directory structure under $DEV_ROOT and $AI_ROOT?" && setup_directories
  confirm "Generate Bash & Zsh profiles with fzf history/aliases?" && setup_profiles
  confirm "Install start-dev launcher script?" && write_start_launcher
  echo -e "\n🎉  Bootstrap completed.  Open a new shell or run:  exec \$SHELL -l"
}

main "$@"
