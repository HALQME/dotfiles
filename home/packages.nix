{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version Control
    git
    git-lfs
    delta
    gh
    ghq
    lazygit
    jujutsu

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
    htop

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
  ];
}
