{ lib, ... }:

{
    options.my.gui = {
      casks = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };

    fonts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    masApps = lib.mkOption {
      type = lib.types.attrsOf lib.types.int;
      default = {};
    };
  };
}
