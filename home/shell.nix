{
  # Zsh Configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;

    # Zsh options (equivalent to setopt)
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

    # Environment variables
    envExtra = ''
      export EDITOR=nvim
    '';

    profileExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';

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
      dco = "docker compose";
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

    # Suffix aliases (run based on file extension)
    # These are set in initExtra since Home Manager doesn't directly support suffix aliases

    # Functions
    initContent = ''
      # Suffix aliases
      alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
      alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
      alias -s {ts,js,tsx,jsx,html}="bun run"
      alias -s py="python3"
      alias -s python="python3"
      alias -s sh="bash"
      alias -s swift="swift"
      alias -s md="glow -p"

      # Global Aliases
      alias -g C=" | tee >(pbcopy)"
      alias -g G=" | rg"
      alias -g L=" | less"
      alias -g N=" ; notify"
      alias -g Cloud="$HOME/Library/CloudStorage/"
      alias -g iCloud="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"

      # Post-command notification
      notify() {
        if [ "$?" = 0 ]; then
          say -i -v 'Samantha' "The task was successful."
        else
          say -i -v 'Ava (Premium)' "The task failed."
        fi
      }

      # Minimize PDF file size using Ghostscript
      pdfmin() {
        local cnt=0
        for i in "$@"; do
          gs -sDEVICE=pdfwrite \
            -dCompatibilityLevel=1.4 \
            -dPDFSETTINGS=/ebook \
            -dNOPAUSE -dQUIET -dBATCH \
            -sOutputFile="''${i%%.*}.min.pdf" "''${i}" &
          # Wait every 4 jobs to avoid overwhelming the system
          (( (cnt += 1) % 4 == 0 )) && wait
        done
        wait && return 0
      }

      # Credentials
      source ~/.config/op/plugins.sh

      # Tool-specific configurations
      export GHQ_ROOT="$HOME/Repo"
      export _ZO_DATA_DIR="''${HOME}/.local/share"
      export OLLAMA_FLASH_ATTENTION=1
      export OLLAMA_CONTEXT_LENGTH=64000
      export HOMEBREW_FORBIDDEN_FORMULAE="node python@3.13 python@3.14 python3 pip npm pnpm yarn"

      # bun completions
      [ -s "''${HOME}/.bun/_bun" ] && source "''${HOME}/.bun/_bun"

      # Zsh Syntax Highlighting (conditional load)
      ZSH_SYNTAX_HIGHLIGHTING_FILE="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      if [[ -f "$ZSH_SYNTAX_HIGHLIGHTING_FILE" ]]; then
        source "$ZSH_SYNTAX_HIGHLIGHTING_FILE"
      fi

    '';
  };

  # Environment Variables and PATH Configuration
  home.sessionVariables = {
    # Tool-specific variables
    BUN_INSTALL = "$HOME/.bun";
    PNPM_HOME = "$HOME/.pnpm";
    GOPATH = "$HOME/.go";
    DOTNET_ROOT = "/usr/local/share/dotnet";
    MODULAR_HOME = "$HOME/.modular";
  };

  home.sessionPath = [
    # Development Tools & SDKs
    "$HOME/.local/share/mise/shims" # Mise
    "$HOME/.modular/pkg/packages.modular.com_mojo/bin" # Modular Mojo
    "$HOME/.ghcup/bin" # Haskell
    "$HOME/.progate/bin" # Progate Path
    "$HOME/.go/bin" # Go Bin (using $HOME/.go instead of $GOPATH for path)
    "$HOME/.bun/bin" # Bun Bin

    # .NET
    "/usr/local/share/dotnet"
  ];

  # Starship Prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza.enable = true;
}
