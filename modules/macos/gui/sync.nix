{ config, lib, ... }:

let
  casks = config.my.gui.casks;
  fonts = config.my.gui.fonts;
  masApps = config.my.gui.masApps;
in
{
  home.activation.guiSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "== GUI sync (brew / fonts / mas) =="

    # Ensure common locations are in PATH so activation can find nix/profile tools
    export PATH="$HOME/.nix-profile/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/.homebrew/bin:$PATH"

    # Find brew binary (prefer command -v after PATH augmentation, fallback to known paths)
    BREW_BIN=$(command -v brew || true)
    if [ -z "$BREW_BIN" ]; then
      for path in /opt/homebrew/bin/brew /usr/local/bin/brew "$HOME/.homebrew/bin/brew" "$HOME/.nix-profile/bin/brew"; do
        if [ -x "$path" ]; then
          BREW_BIN="$path"
          break
        fi
      done
    fi

    if [ -z "$BREW_BIN" ]; then
      echo "brew not found. Skipping cask/font sync."
    else
      # Installed casks (may include font-* items)
      installed_casks=$($BREW_BIN list --cask 2>/dev/null || true)
      if [ -z "$installed_casks" ]; then
        echo "No installed casks found."
      fi
      installed_font_casks=$(echo "$installed_casks" | grep "^font-" || true)
      if [ -z "$installed_font_casks" ]; then
        echo "No installed font casks found."
      fi

      # Desired lists from Nix
      desired_casks="${lib.concatStringsSep " " casks}"
      desired_fonts="${lib.concatStringsSep " " fonts}"
      desired_mas_ids="${
        lib.concatMapStringsSep " " (name: toString masApps.${name}) (builtins.attrNames masApps)
      }"

      # Install desired casks
      for c in $desired_casks; do
        if [ -z "$c" ]; then continue; fi
        if ! echo "$installed_casks" | grep -q "^$c$"; then
          echo "Installing cask: $c"
          if $BREW_BIN install --cask "$c"; then
            echo "Successfully installed cask: $c"
          else
            echo "Failed to install cask: $c"
          fi
        else
          echo "Cask already installed: $c"
        fi
      done

      # Uninstall unmanaged casks (skip font-* casks)
      for pkg in $installed_casks; do
        case "$pkg" in
          font-*) continue ;;
        esac
        if ! echo " $desired_casks " | grep -q " $pkg "; then
          echo "Uninstalling unmanaged cask: $pkg"
          if $BREW_BIN uninstall --cask "$pkg"; then
            echo "Successfully uninstalled cask: $pkg"
          else
            echo "Failed to uninstall cask: $pkg"
          fi
        fi
      done

      # Ensure fonts tap and install desired fonts
      $BREW_BIN tap homebrew/cask-fonts >/dev/null 2>&1 || true
      for f in $desired_fonts; do
        if [ -z "$f" ]; then continue; fi
        if ! echo "$installed_font_casks" | grep -q "^$f$"; then
          echo "Installing font: $f"
          if $BREW_BIN install --cask "$f"; then
            echo "Successfully installed font: $f"
          else
            echo "Failed to install font: $f"
          fi
        else
          echo "Font already installed: $f"
        fi
      done
    fi

    # Find mas binary (may live in $HOME/.nix-profile/bin)
    MAS_BIN=$(command -v mas || true)
    if [ -z "$MAS_BIN" ] && [ -x "$HOME/.nix-profile/bin/mas" ]; then
      MAS_BIN="$HOME/.nix-profile/bin/mas"
    fi

    # MAS apps (if mas CLI is available)
    if [ -n "$MAS_BIN" ]; then
      ${lib.concatMapStringsSep "\n" (
        name:
        let
          id = masApps.${name};
        in
        ''
          $MAS_BIN install ${toString id}
        ''
      ) (builtins.attrNames masApps)}
    else
      echo "mas CLI not found. Skipping MAS app sync."
    fi
  '';
}
