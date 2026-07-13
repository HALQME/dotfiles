if [[ -o interactive ]]; then
  if [ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  elif [ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
  fi
fi

if [[ -o interactive ]]; then
  if [ -f /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  elif [ -f /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  fi
fi

if [[ -o interactive ]] && [[ -o zle ]] && [ -f "$HOME/.config/zsh/.p10k.zsh" ]; then
  source "$HOME/.config/zsh/.p10k.zsh"
fi
