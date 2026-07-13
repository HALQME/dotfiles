# `fzf --zsh` provides completion and the Ctrl-T / Alt-C key bindings. Cache its
# generated script and refresh it when the fzf executable changes.
if [[ -o interactive ]] && (( $+commands[fzf] )); then
  fzf_zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  fzf_zsh_cache_file="$fzf_zsh_cache_dir/fzf.zsh"

  if [[ ! -r "$fzf_zsh_cache_file" || "${commands[fzf]}" -nt "$fzf_zsh_cache_file" ]]; then
    if mkdir -p -- "$fzf_zsh_cache_dir" 2>/dev/null; then
      fzf_zsh_cache_tmp="$fzf_zsh_cache_file.$$"
      if command fzf --zsh >| "$fzf_zsh_cache_tmp"; then
        mv -f -- "$fzf_zsh_cache_tmp" "$fzf_zsh_cache_file"
      else
        rm -f -- "$fzf_zsh_cache_tmp"
      fi
    fi
  fi

  if [[ -r "$fzf_zsh_cache_file" ]]; then
    source "$fzf_zsh_cache_file"
  else
    source <(command fzf --zsh)
  fi

  unset fzf_zsh_cache_dir fzf_zsh_cache_file fzf_zsh_cache_tmp
fi
