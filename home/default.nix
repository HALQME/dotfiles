{
  imports = [
    ./aliases.nix
    ./git.nix
    ./packages.nix
    ./programs.nix
    ./session.nix
    ./shell.nix
    ../modules/config-files/options.nix
    ../modules/config-files/linker.nix
    ../modules/config-files/config.nix
  ];

  xdg.enable = true;

  programs.home-manager.enable = true;
}
