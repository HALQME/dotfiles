# Keep this file deliberately small. Feature-specific startup code belongs in
# autoload/, which Nushell sources after config.nu in lexical order.
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

source '~/.vite-plus/env.nu'