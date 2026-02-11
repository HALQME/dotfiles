{
  imports = [
    ./shell.nix
    ./git.nix
    ./packages.nix
    ../modules/config-files/options.nix
    ../modules/config-files/linker.nix
    ../modules/config-files/config.nix
  ];

  xdg.enable = true;

  programs.home-manager.enable = true;
}
