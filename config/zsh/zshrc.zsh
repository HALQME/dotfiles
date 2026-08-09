# Interactive-shell configuration, sourced by the mise-managed ~/.zshrc block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g ZSH_CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "$ZSH_CONFIG_ROOT/lib/loader.zsh"
source "$ZSH_CONFIG_ROOT/lib/defer.zsh"

# Phase order is the configuration contract. Keep widget wrappers last.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh --shims)"
fi

zsh_load_required_phase common/10-shell.zsh
zsh_load_optional_phase platform/10-paths.zsh
zsh_load_required_phase plugins/completion.zsh
zsh_load_optional_phase platform/80-prompt.zsh
zsh_load_required_phase plugins/input.zsh plugins/tools.zsh
