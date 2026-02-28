{ lib, ... }:

{
  options.my.configFiles = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          source = lib.mkOption {
            type = lib.types.path;
          };

          target = lib.mkOption {
            type = lib.types.str;
          };
        };
      }
    );
    default = { };
  };
}
