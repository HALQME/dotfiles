{...}: {
  imports = [
    ../../modules/common/base.nix
    ../../modules/platform/darwin/config.nix
    ../../profiles/hal/home.nix
    ./git.nix
    ./ssh.nix
  ];
}
