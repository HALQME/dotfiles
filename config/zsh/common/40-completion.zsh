# Load third-party completion definitions before compinit, then let fzf-tab
# render the resulting candidates. Widget-wrapping plugins load later.
if [[ -o interactive ]]; then
  zsh_completion_dir=/opt/homebrew/share/zsh-completions
  fzf_tab_plugin=/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh

  if [[ -d "$zsh_completion_dir" || -r "$fzf_tab_plugin" ]]; then
    [[ -d "$zsh_completion_dir" ]] && fpath=("$zsh_completion_dir" $fpath)
    autoload -Uz compinit

    zsh_completion_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    zsh_completion_dump="$zsh_completion_cache_dir/zcompdump"
    if mkdir -p -- "$zsh_completion_cache_dir" 2>/dev/null; then
      # Run compaudit when the completion set changes. Cached shells skip that
      # scan; all fpath entries here are Homebrew or system-managed paths.
      if [[ ! -r "$zsh_completion_dump" || "$zsh_completion_dir" -nt "$zsh_completion_dump" || "$fzf_tab_plugin" -nt "$zsh_completion_dump" ]]; then
        compinit -d "$zsh_completion_dump"
      else
        compinit -C -d "$zsh_completion_dump"
      fi
    else
      compinit
    fi

    [[ -r "$fzf_tab_plugin" ]] && source "$fzf_tab_plugin"
  fi

  unset zsh_completion_dir fzf_tab_plugin zsh_completion_cache_dir zsh_completion_dump
fi
