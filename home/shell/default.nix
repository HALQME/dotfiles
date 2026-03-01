{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    defaultKeymap = "emacs";

    # Zsh options
    setOptions = [
      "PRINT_EIGHT_BIT"
      "INTERACTIVE_COMMENTS"
      "AUTO_CD"
      "EXTENDED_HISTORY"
      "RM_STAR_SILENT"
      "SHARE_HISTORY"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_REDUCE_BLANKS"
    ];

    # Plugins
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-abbr";
        src = pkgs.zsh-abbr;
        file = "share/zsh/site";
      }
    ];

    envExtra = ''
      export EDITOR=nvim
    '';

    profileExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';

    initContent = builtins.readFile ./zshrc-extra.sh;
  };
}