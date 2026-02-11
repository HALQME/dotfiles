{ config, lib, ... }:

let
  files = config.my.configFiles;

  homeFiles =
    lib.filterAttrs (_: v:
      lib.hasPrefix "/" v.target ||
      lib.hasPrefix "." v.target
    ) files;

  xdgFiles =
    lib.filterAttrs (_: v:
      lib.hasPrefix "config/" v.target
    ) files;
in
{
  home.file =
    lib.mapAttrs'
      (name: v:
        lib.nameValuePair v.target {
          source = v.source;
        }
      )
      homeFiles;

  xdg.configFile =
    lib.mapAttrs'
      (name: v:
        lib.nameValuePair
          (lib.removePrefix "config/" v.target)
          {
            source = v.source;
          }
      )
      xdgFiles;
}
