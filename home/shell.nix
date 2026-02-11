{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -al";
      g = "git";
    };
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
