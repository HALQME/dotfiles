# `fzf --zsh` provides completion and the Ctrl-T / Alt-C key bindings.
if [[ -o interactive ]] && (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi
