{...}: {
  imports = [
    ./config.nix
    ./env.nix
    ./git.nix
    ./mise.nix
    ./packages.nix
    ./programs.nix
    ./shell.nix
  ];

  xdg.enable = true;
}
