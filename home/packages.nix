{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version Control
    git
    delta
    gh
    ghq
    lazygit

    # Shell
    zsh
    starship
    zoxide
    direnv

    # Search & Navigation
    ripgrep
    fd
    fzf

    # File Viewers
    bat
    eza

    # Terminal Multiplexers
    tmux
    zellij

    # Editors
    neovim

    # System Monitoring
    bottom
    dust

    # Task Runner
    go-task

    # Media
    yt-dlp

    # Markdown
    glow
    marksman

    # CI/CD
    act

    # Language Runtimes
    go
    nodejs
    rustup
    zig

    # Language Servers
    lua-language-server
    gopls

    # Package Managers
    pnpm

    # Python
    uv

    # Build Tools
    jq
    mas
  ];
}
