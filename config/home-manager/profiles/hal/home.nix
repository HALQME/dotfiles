{...}: {
  imports = [
    ./git.nix
    ./nix.nix
  ];

  xdg.enable = true;
}
