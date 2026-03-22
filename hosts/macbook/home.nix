{ enableGuiSync ? false, ... }:

let
  syncModule = if enableGuiSync then [ ../../modules/macos/gui/sync.nix ] else [];
in
{
  imports = [
    ../../home
    ../../modules/macos/gui/options.nix
    ../../modules/macos/gui/casks.nix
    ../../modules/macos/gui/font.nix
    ../../modules/macos/gui/mas.nix
  ] ++ syncModule ++ [
    ../../modules/macos/config-files.nix
  ];

  home.username = "hal";
  home.homeDirectory = "/Users/hal";

  home.stateVersion = "26.05";
}
