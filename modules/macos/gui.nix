{ pkgs, lib, ... }:
let
  isDarwin = builtins.hasAttr "stdenv" pkgs && (pkgs.stdenv.isDarwin or false);
in
lib.mkIf isDarwin {
  # Re-use existing macOS-only gui modules (kept under modules/gui)
  imports = [
    ../gui/options.nix
    ../gui/casks.nix
    ../gui/font.nix
    ../gui/mas.nix
    ../gui/sync.nix
  ];
}
