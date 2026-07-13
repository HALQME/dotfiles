if [[ -o interactive ]]; then
  if [ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  elif [ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
  fi
fi

_load_interactive_enhancements() {
  if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  elif [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi

  if [ -f /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  elif [ -f /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  fi
}

# Defer widget-wrapping plugins until the first typed character, so the initial
# prompt can appear without waiting for them to load. Autosuggestions loads
# before syntax highlighting, which must be last among widget wrappers.
if [[ -o interactive && -o zle ]]; then
  _load_interactive_enhancements_on_first_input() {
    unfunction _load_interactive_enhancements_on_first_input
    zle -A .self-insert self-insert
    _load_interactive_enhancements
    zle self-insert
  }
  zle -N self-insert _load_interactive_enhancements_on_first_input
fi

if [[ -o interactive ]] && [[ -o zle ]] && [ -f "$HOME/.config/zsh/.p10k.zsh" ]; then
  source "$HOME/.config/zsh/.p10k.zsh"
fi
