{ lib, ... }:

{
  options.my.configFiles = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          source = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
          };

          target = lib.mkOption {
            type = lib.types.str;
          };

          text = lib.mkOption {
            type = lib.types.str;
            default = "";
          };

          mode = lib.mkOption {
            type = lib.types.str;
            default = "0644";
          };
        };
      }
    );
    default = { };
  };
}
