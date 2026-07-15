export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

path=(
  "$HOME/.local/bin"
  "$HOME/.modular/pkg/packages.modular.com_mojo/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.go/bin"
  "$HOME/.pnpm/bin"
  "$HOME/.bun/bin"
  "$HOME/.deno/bin"
  "$HOME/.moon/bin"
  "$HOME/.lmstudio/bin"
  $path
)
typeset -U path
export PATH

alias -g C='| tee >(pbcopy)'
alias -g P='| pbpaste'
alias -g Cloud="$HOME/Library/CloudStorage/"
