{ pkgs, lib, ... }:
let
  isDarwin = builtins.hasAttr "stdenv" pkgs && (pkgs.stdenv.isDarwin or false);
in
lib.mkIf isDarwin {
  home.file.".config/karabiner".source = ./../../config/karabiner;
}
