{ config, lib, ... }:

let
  files = config.my.configFiles;

  homeFiles = lib.filterAttrs (_: v: lib.hasPrefix "/" v.target || lib.hasPrefix "." v.target) files;
  xdgFiles = lib.filterAttrs (_: v: lib.hasPrefix "config/" v.target) files;

  # Separate source-based files from text-based files
  sourceBasedHomeFiles = lib.filterAttrs (_: v: v.source != null) homeFiles;
  textBasedHomeFiles = lib.filterAttrs (_: v: v.source == null) homeFiles;

  sourceBasedXdgFiles = lib.filterAttrs (_: v: v.source != null) xdgFiles;
  textBasedXdgFiles = lib.filterAttrs (_: v: v.source == null) xdgFiles;
in
{
  home.file =
    # Source-based files
    lib.mapAttrs' (
      name: v:
      lib.nameValuePair v.target {
        source = v.source;
        recursive = builtins.pathExists (toString v.source + "/.");
      }
    ) sourceBasedHomeFiles
    # Text-based files
    // lib.mapAttrs' (
      name: v:
      lib.nameValuePair v.target {
        text = v.text;
      }
    ) textBasedHomeFiles;

  home.activation.initZed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f ~/.config/zed/settings.json ]; then
      cp ${../../config/zed/settings.json} ~/.config/zed/settings.json
    fi
  '';

  xdg.configFile =
    # Source-based files
    lib.mapAttrs' (
      name: v:
      lib.nameValuePair (lib.removePrefix "config/" v.target) {
        source = v.source;
        recursive = builtins.pathExists (toString v.source + "/.");
      }
    ) sourceBasedXdgFiles
    # Text-based files
    // lib.mapAttrs' (
      name: v:
      lib.nameValuePair (lib.removePrefix "config/" v.target) {
        text = v.text;
      }
    ) textBasedXdgFiles;
}