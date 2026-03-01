{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version Control
    delta
    gh
    ghq
    lazygit
    jujutsu

    # Shell
    zsh
    comma

    # Search & Navigation
    ripgrep
    fd

    # File Viewers
    bat

    # Terminal Multiplexers
    tmux
    zellij

    # Editors
    neovim

    # System Monitoring
    bottom
    dust
    htop

    # Task Runner
    go-task

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

    nil
    nixd

    # Package Managers
    pnpm

    # Python
    uv

    # Build Tools
    jq
    mas

    imagemagick
    texliveSmall
    ffmpeg
    ripgrep
    aria2
    d2
    tart
    lsd
  ];
}
