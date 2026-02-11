{
  imports = [
    ./shell.nix
    ./git.nix
    ./packages.nix
  ];

  xdg.enable = true;

  programs.home-manager.enable = true;
}
