{...}: {
  imports = [
    ./env.nix
    ./git.nix
    ./nix.nix
  ];

  xdg.enable = true;
}
