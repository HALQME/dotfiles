
{ config, lib, ... }:

  let
  casks = config.my.gui.casks;
  fonts = config.my.gui.fonts;
  masApps = config.my.gui.masApps;
 in
{
  home.activation.guiSync = lib.hm.dag.entryAfter ["writeBoundary"] ''

    echo "== Brew Cask Sync =="

    # Find brew binary
    BREW_BIN=""
    for path in /opt/homebrew/bin/brew /usr/local/bin/brew "$HOME/.homebrew/bin/brew"; do
      if [ -x "$path" ]; then
        BREW_BIN="$path"
        break
      fi
    done

    if [ -z "$BREW_BIN" ]; then
      echo "Warning: brew not found in common locations. Skipping cask sync."
      echo "Install Homebrew or ensure it's in /opt/homebrew/bin, /usr/local/bin, or ~/.homebrew/bin"
      exit 0
    fi

    installed_casks=$($BREW_BIN list --cask 2>/dev/null || true)

    # Determine which installed casks are fonts (font-*). We'll manage font
    # casks separately and therefore avoid uninstalling them in the general
    # cask cleanup below.
    installed_font_casks=$(echo "$installed_casks" | grep "^font-" || true)

    # Install configured casks
    ${lib.concatMapStringsSep "\n" (cask: ''
      if ! echo "$installed_casks" | grep -q "^${cask}$"; then
        $BREW_BIN install --cask ${cask}
      fi
    '') casks}

    # Uninstall unmanaged casks (present but not in config). Skip any font
    # casks because fonts are managed separately via my.gui.fonts.
    for pkg in $installed_casks; do
      # Skip font casks (they are handled separately)
      case "$pkg" in
        font-*) continue ;;
      esac

      case " ${lib.concatStringsSep " " casks} " in
        *" $pkg "*) ;;
        *) $BREW_BIN uninstall --cask "$pkg" ;;
      esac
    done

    # Install fonts (managed separately). Treat entries in my.gui.fonts as
    # Homebrew font casks (font-*) and ensure they're installed.
    # Ensure the fonts tap is available (many fonts live in homebrew/cask-fonts)
    $BREW_BIN tap homebrew/cask-fonts >/dev/null 2>&1 || true
    ${lib.concatMapStringsSep "\n" (font: ''
      if ! echo "$installed_font_casks" | grep -q "^${font}$"; then
        $BREW_BIN install --cask ${font}
      fi
    '') fonts}


    echo "== MAS Sync =="

    if command -v mas >/dev/null; then
      installed_mas=$(mas list | awk '{print $1}')

      ${lib.concatMapStringsSep "\n" (name:
        let id = masApps.${name}; in ''
        if ! echo "$installed_mas" | grep -q "^${toString id}$"; then
          mas install ${toString id}
        fi
      '') (builtins.attrNames masApps)}

    fi
  '';
}
