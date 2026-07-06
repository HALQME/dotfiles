{repoRoot, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  home.file = {
    ".hushlogin".text = "";
  };

  xdg.configFile = {
    "homebrew/Brewfile".source = repoRoot + /config/homebrew/Brewfile;
    "karabiner".source = repoRoot + /config/karabiner;
  };
}
