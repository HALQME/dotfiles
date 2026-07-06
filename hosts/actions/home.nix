{...}: {
  imports = [
    ../../modules/common/base.nix
    ../../profiles/hal/home.nix
    ./config.nix
    ./packages.nix
  ];
}
