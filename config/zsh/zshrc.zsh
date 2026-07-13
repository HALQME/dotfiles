# Interactive-shell configuration, sourced by the mise-managed ~/.zshrc block.
typeset -g ZSH_CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "$ZSH_CONFIG_ROOT/lib/loader.zsh"
source "$ZSH_CONFIG_ROOT/lib/defer.zsh"

# Phase order is the configuration contract. Keep widget wrappers last.
zsh_load_required_phase common/10-shell.zsh
zsh_load_optional_phase platform/10-paths.zsh
zsh_load_required_phase plugins/completion.zsh
zsh_load_optional_phase platform/80-prompt.zsh
zsh_load_required_phase plugins/input.zsh plugins/tools.zsh
