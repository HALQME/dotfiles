{
  programs.zsh = {
    # Global aliases (can be used anywhere in a command)
    shellGlobalAliases = {
      C = "| tee >(pbcopy)";
      G = "| rg";
      L = "| less";
      N = "; notify";
      P = "| pbpaste";
      Cloud = "$HOME/Library/CloudStorage/";
      iCloud = "$HOME/Library/Mobile\\ Documents/com~apple~CloudDocs/";
    };

    # Regular aliases
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..2" = "cd ../..";
      "..3" = "cd ../../..";
      "~" = "cd ~";
      repo = "local repodir=$(ghq list | fzf -1 +m) && cd $(ghq root)/$repodir";

      # Core tools
      c = "clear";
      ls = "lsd";
      ll = "lsd -la";
      lg = "lazygit";
      grep = "rg";
      glor = "glow -p";
      d = "docker";
      dc = "docker compose";
      mp = "multipass";
      edit = "vim";
      orb = "TERM=xterm-256color orb";

      # Overwrite built-ins with safer versions
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      mkdir = "mkdir -p";
      history = "history -t \"%F %T\"";

      # System/utility aliases
      df = "df -h";
      du = "du -h";
      calc = "bc -l";
      datestamp = "date +%Y%m%d%H%M%S";
      ipinfo = "curl ipinfo.io";
      weather = "curl wttr.in";
      speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -";
      untar = "tar -zxvf";
      port = "lsof -i";

      # App/tool specific aliases
      brew-backup = "brew bundle dump --force --file ~/Brewfile --describe";
      gh-copilot = "COPILOT_MODEL=gpt-5-mini copilot";
      gptk = "gameportingtoolkit-no-hud ~/$MY_GAME_PREFIX";
      pdftohtml = "pdftohtml -enc UTF-8 -noframes";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
      yt-dlp-f = "yt-dlp --no-check-certificate";
      zj = "zellij attach default || zellij --session default";
    };

  };
}
