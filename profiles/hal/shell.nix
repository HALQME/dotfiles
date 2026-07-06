{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    setOptions = [
      "AUTO_PUSHD"
      "HIST_IGNORE_SPACE"
      "HIST_REDUCE_BLANKS"
      "INTERACTIVE_COMMENTS"
      "NO_BEEP"
      "PRINT_EIGHT_BIT"
      "PUSHD_IGNORE_DUPS"
      "RM_STAR_SILENT"
    ];

    history = {
      extended = true;
      ignoreAllDups = true;
      share = true;
      size = 10000;
    };

    siteFunctions.mkcd = ''
      mkdir --parents "$1" && cd "$1"
    '';

    shellGlobalAliases = {
      G = "| rg";
      L = "| less -R";
    };

    shellAliases = {
      ".." = "cd ..";
      "..2" = "cd ../..";
      "~" = "cd ~";

      c = "clear";
      ls = "eza";
      ll = "eza -la";
      lg = "lazygit";
      grep = "rg";
      nf = "nix flake";
      nd = "nix develop --command $SHELL";

      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      mkdir = "mkdir -p";
      less = "less -R";
      history = "history -t \"%F %T\"";
      untar = "tar -zxvf";

      d = "docker";
      dc = "docker compose";
      orb = "TERM=xterm-256color orb";
      df = "df -h";
      du = "du -h";
      calc = "bc -l";
      datestamp = "date +%Y%m%d%H%M%S";
      ipinfo = "curl ipinfo.io";
      weather = "curl wttr.in";
      port = "lsof -i";
      repo = "cd $(ghq list --full-path | fzf)";
    };

    initContent = ''
      # Some prompt/completion snippets assume these exist and trip over unset vars.
      export SSH_CONNECTION="''${SSH_CONNECTION-}"
      export SSH_CLIENT="''${SSH_CLIENT-}"
      export SSH_TTY="''${SSH_TTY-}"

      alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="gat"

      alias -s {ts,js,tsx,jsx,html,md}="bun run"
      alias -s py="python3"
      alias -s python="python3"
      alias -s sh="bash"
      alias -s swift="swift"
      alias -s cr="crystal"

      if [[ -o interactive ]]; then
        source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
      fi

      if [[ -o interactive ]] && [[ -o zle ]]; then
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      fi

      if [[ -o interactive ]] && [[ -o zle ]] && [ -f "$HOME/.config/zsh/.p10k.zsh" ]; then
        source "$HOME/.config/zsh/.p10k.zsh"
      fi

      if [[ -o interactive ]] && [ -s "$HOME/.bun/_bun" ]; then
        source "$HOME/.bun/_bun"
      fi

      if [ -s "$HOME/.vite-plus/env" ]; then
        source "$HOME/.vite-plus/env"
      fi
    '';
  };
}
