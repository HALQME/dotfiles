# ============================================================================
# ZSH EXTRA CONFIGURATION
# ============================================================================
# This file contains custom functions, aliases, and tool configurations
# that extend the base Zsh configuration.

# ============================================================================
# SUFFIX ALIASES - File type shortcuts
# ============================================================================
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias -s {ts,js,tsx,jsx,html}="bun run"
alias -s py="python3"
alias -s python="python3"
alias -s sh="bash"
alias -s swift="swift"
alias -s md="glow -p"

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Post-command notification (macOS)
# Usage: command; notify
notify() {
  if [ "$?" = 0 ]; then
    say -i -v 'Samantha' "The task was successful."
  else
    say -i -v 'Ava (Premium)' "The task failed."
  fi
}

# Minimize PDF file size using Ghostscript
# Usage: pdfmin file1.pdf file2.pdf
pdfmin() {
  local cnt=0
  for i in "$@"; do
    gs -sDEVICE=pdfwrite \
      -dCompatibilityLevel=1.4 \
      -dPDFSETTINGS=/ebook \
      -dNOPAUSE -dQUIET -dBATCH \
      -sOutputFile="${i%%.*}.min.pdf" "${i}" &
    # Wait every 4 jobs to avoid overwhelming the system
    (( (cnt += 1) % 4 == 0 )) && wait
  done
  wait && return 0
}

# ============================================================================
# CREDENTIALS & SECURITY
# ============================================================================
# Load 1Password CLI completions and integrations
if [ -f "$HOME/.config/op/plugins.sh" ]; then
  source "$HOME/.config/op/plugins.sh"
fi

# ============================================================================
# TOOL CONFIGURATION - Environment Variables
# ============================================================================

# Version Control
export GHQ_ROOT="$HOME/Repo"

# Navigation
export _ZO_DATA_DIR="${HOME}/.local/share"

# LLM & AI
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_CONTEXT_LENGTH=64000

# Package Manager
export HOMEBREW_FORBIDDEN_FORMULAE="node python@3.13 python@3.14 python3 pip npm pnpm yarn"

# ============================================================================
# COMPLETIONS & INTEGRATIONS
# ============================================================================

# Bun completions
if [ -s "${HOME}/.bun/_bun" ]; then
  source "${HOME}/.bun/_bun"
fi

# Powerlevel10k - theme configuration
# Load after all other initializations
if [ -f "$HOME/.p10k.zsh" ]; then
  source "$HOME/.p10k.zsh"
fi