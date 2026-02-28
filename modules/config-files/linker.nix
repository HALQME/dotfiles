{ config, lib, ... }:

let
  files = config.my.configFiles;

  homeFiles = lib.filterAttrs (_: v: lib.hasPrefix "/" v.target || lib.hasPrefix "." v.target) files;

  xdgFiles = lib.filterAttrs (_: v: lib.hasPrefix "config/" v.target) files;
in
{
  home.file = lib.mapAttrs' (
    name: v:
    lib.nameValuePair v.target {
      source = v.source;
      recursive = builtins.pathExists (toString v.source + "/.");
    }
  ) homeFiles;

  home.activation.initZed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f ~/.config/zed/settings.json ]; then
      cp ${../../config/zed/settings.json} ~/.config/zed/settings.json
    fi
  '';

  xdg.configFile = lib.mapAttrs' (
    name: v:
    lib.nameValuePair (lib.removePrefix "config/" v.target) {
      source = v.source;
      recursive = builtins.pathExists (toString v.source + "/.");
    }
  ) xdgFiles;
}
