{
  # ============================================================================
  # HOME MANAGER CONFIGURATION
  # ============================================================================
  # Central configuration file that imports all home-manager modules
  # organized by functional category.

  imports = [
    # ========================================================================
    # SHELL CONFIGURATION
    # ========================================================================
    ./shell/default.nix                # Zsh configuration
    ./shell/aliases.nix                # Shell aliases

    # ========================================================================
    # VERSION CONTROL
    # ========================================================================
    ./git/default.nix                  # Git configuration & delta

    # ========================================================================
    # DEVELOPMENT TOOLS & PACKAGES
    # ========================================================================
    ./dev/programs.nix                 # CLI programs and utilities
    ./dev/packages.nix                 # System packages
    ./dev/session.nix                  # Environment variables & PATH

    # ========================================================================
    # EXTERNAL MODULES
    # ========================================================================
    ../modules/config-files/options.nix   # Configuration file options
    ../modules/config-files/linker.nix    # File linking utilities
    ../modules/config-files/config.nix    # Custom configuration
  ];

  # ============================================================================
  # HOME MANAGER CORE SETTINGS
  # ============================================================================
  xdg.enable = true;                    # Use XDG Base Directory Specification
  programs.home-manager.enable = true;  # Enable home-manager self-management
}