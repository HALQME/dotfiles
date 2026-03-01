{
  imports = [
    ../../home
    ../../modules/gui/options.nix
    ../../modules/gui/casks.nix
    ../../modules/gui/font.nix
    ../../modules/gui/mas.nix
    ../../modules/gui/sync.nix
  ];

  home.username = "hal";
  home.homeDirectory = "/Users/hal";

  home.stateVersion = "26.05";
}
