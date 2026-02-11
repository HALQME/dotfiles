
{ config, lib, ... }:

let
  casks = config.my.gui.casks;
  masApps = config.my.gui.masApps;
in
{
  home.activation.guiSync = lib.hm.dag.entryAfter ["writeBoundary"] ''

    echo "== Brew Cask Sync =="

    installed_casks=$(brew list --cask 2>/dev/null || true)

    ${lib.concatMapStringsSep "\n" (cask: ''
      if ! echo "$installed_casks" | grep -q "^${cask}$"; then
        brew install --cask ${cask}
      fi
    '') casks}

    for pkg in $installed_casks; do
      case " ${lib.concatStringsSep " " casks} " in
        *" $pkg "*) ;;
        *) brew uninstall --cask "$pkg" ;;
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
