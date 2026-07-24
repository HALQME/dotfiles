# Login-shell configuration, sourced by the mise-managed ~/.zprofile block.
# mise activation runs immediately after this file, so its executable must be
# reachable before the interactive-shell PATH configuration is loaded.
path=(
  "/opt/homebrew/bin"
  "/usr/local/bin"
  $path
)
typeset -U path
export PATH
