{ pkgs, ... }:

{
  # ============================================================================
  # PACKAGES
  # ============================================================================
  # This file defines all system packages installed via home-manager.
  # Packages are organized by category for clarity and maintainability.

  home.packages = with pkgs; [
    # ========================================================================
    # VERSION CONTROL
    # ========================================================================
    delta                               # Syntax-highlighting diff viewer
    gh                                  # GitHub CLI
    ghq                                 # Repository manager

    # ========================================================================
    # SHELL & UTILITIES
    # ========================================================================
    comma                               # Run programs without installing them

    # ========================================================================
    # SEARCH & NAVIGATION
    # ========================================================================
    ripgrep                             # Fast grep alternative (rg)
    fd                                  # Fast find alternative

    # ========================================================================
    # SYSTEM MONITORING
    # ========================================================================
    dust                                # Disk usage visualization
    htop                                # Interactive process viewer

    # ========================================================================
    # TASK RUNNING & AUTOMATION
    # ========================================================================
    go-task                             # Task runner (Makefile alternative)

    # ========================================================================
    # DOCUMENTATION & MARKUP
    # ========================================================================
    glow                                # Markdown viewer
    marksman                            # Markdown language server

    # ========================================================================
    # CI/CD
    # ========================================================================
    act                                 # Run GitHub Actions locally

    # ========================================================================
    # PROGRAMMING LANGUAGE RUNTIMES
    # ========================================================================
    go                                  # Go programming language
    nodejs                              # Node.js runtime
    rustup                              # Rust toolchain installer
    zig                                 # Zig programming language

    # ========================================================================
    # LANGUAGE SERVERS & DEVELOPMENT TOOLS
    # ========================================================================
    lua-language-server                 # Lua LSP
    gopls                               # Go language server
    nil                                 # Nix language server
    nixd                                # Modern Nix language server

    # ========================================================================
    # PACKAGE MANAGERS
    # ========================================================================
    pnpm                                # Fast Node.js package manager

    # ========================================================================
    # PYTHON
    # ========================================================================
    uv                                  # Fast Python package installer & resolver

    # ========================================================================
    # BUILD TOOLS & UTILITIES
    # ========================================================================
    jq                                  # JSON query tool
    mas                                 # Mac App Store CLI

    # ========================================================================
    # MEDIA & GRAPHICS
    # ========================================================================
    imagemagick                         # Image processing suite
    texliveSmall                        # LaTeX distribution (minimal)
    ffmpeg                              # Multimedia framework
    aria2                               # Download utility
    d2                                  # Diagram creation language
    tart                                # macOS & Linux VM manager

    # ========================================================================
    # FILE OPERATIONS & DISPLAY
    # ========================================================================
    lsd                                 # Modern ls alternative with icons
  ];
}