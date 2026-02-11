{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    zoxide
    starship
    direnv
    neovim
    mas
  ];
}
