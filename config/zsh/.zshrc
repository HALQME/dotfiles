# Managed by mise dotfiles — see ~/.dotfiles/mise/config.toml

zsh_config_root="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
for zsh_config_file in "$zsh_config_root/common"/*.zsh(N) "$zsh_config_root/platform"/*.zsh(N); do
  source "$zsh_config_file"
done
unset zsh_config_root zsh_config_file
