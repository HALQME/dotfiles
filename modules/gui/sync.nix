
{ config, lib, ... }:

let
  casks = config.my.gui.casks;
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

    ${lib.concatMapStringsSep "\n" (cask: ''
      if ! echo "$installed_casks" | grep -q "^${cask}$"; then
        $BREW_BIN install --cask ${cask}
      fi
    '') casks}

    for pkg in $installed_casks; do
      case " ${lib.concatStringsSep " " casks} " in
        *" $pkg "*) ;;
        *) $BREW_BIN uninstall --cask "$pkg" ;;
      esac
    done


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
