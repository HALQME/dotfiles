{ pkgs, lib, ... }:
let
  isDarwin = builtins.hasAttr "stdenv" pkgs && (pkgs.stdenv.isDarwin or false);
in
lib.mkIf isDarwin {
  home.file.".hammerspoon".source = ./../../config/hammerspoon;
}
