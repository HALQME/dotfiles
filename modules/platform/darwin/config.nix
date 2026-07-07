{repoRoot, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  };

  home.file = {
    ".hushlogin".text = "";
  };

  xdg.configFile = {
    "homebrew/Brewfile".source = repoRoot + /config/homebrew/Brewfile;
    "karabiner".source = repoRoot + /config/karabiner;
  };
}
