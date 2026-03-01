{
  # ============================================================================
  # DEVELOPMENT TOOLS & CLI PROGRAMS
  # ============================================================================
  # This file enables and configures various CLI tools and development
  # programs through home-manager.

  # ============================================================================
  # FILE & TEXT TOOLS
  # ============================================================================
  programs.bat.enable = true; # Syntax-highlighted cat
  programs.ripgrep.enable = true; # Fast grep alternative (rg)

  # ============================================================================
  # SYSTEM MONITORING & UTILITIES
  # ============================================================================
  programs.bottom.enable = true; # System resource monitor

  # ============================================================================
  # ENVIRONMENT & SHELL INTEGRATION
  # ============================================================================
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Use nix-direnv for better Nix support
    enableZshIntegration = true; # Auto-load .envrc when entering directories
  };

  # ============================================================================
  # FILE LISTING & NAVIGATION
  # ============================================================================
  programs.eza.enable = true; # Modern ls alternative
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true; # Track and jump to frequently used directories
  };

  # ============================================================================
  # FUZZY FINDING & SEARCHING
  # ============================================================================
  programs.fzf = {
    enable = true;
    enableZshIntegration = true; # Fuzzy finder for command line
  };

  # ============================================================================
  # VERSION CONTROL
  # ============================================================================
  programs.jujutsu.enable = true; # Modern VCS (experimental)
  programs.lazygit.enable = true; # Interactive git CLI

  # ============================================================================
  # EDITORS
  # ============================================================================
  programs.neovim.enable = true; # Vim-based text editor

  # ============================================================================
  # PACKAGE & INDEX MANAGEMENT
  # ============================================================================
  programs.nix-index.enable = true; # Quickly search packages in nixpkgs

  # ============================================================================
  # TERMINAL MULTIPLEXING
  # ============================================================================
  programs.tmux.enable = true; # Terminal multiplexer
  programs.zellij.enable = true; # Modern terminal workspace
}
