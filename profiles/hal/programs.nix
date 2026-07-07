{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config.global.log_filter = "^$";
    nix-direnv = {
      enable = true;
    };

    stdlib = ''
      use_age() {
        local encrypted_file="''${1:-.env.age}"
        local tmp_file
        local status

        [ -f "$encrypted_file" ] || return 0

        watch_file "$encrypted_file"
        tmp_file="$(mktemp)"

        if ! ${pkgs.age}/bin/age \
          --decrypt \
          -i "$HOME/.config/age/identity.age" \
          "$encrypted_file" \
          > "$tmp_file"
        then
          rm -f "$tmp_file"
          return 1
        fi

        dotenv "$tmp_file"
        status=$?

        rm -f "$tmp_file"
        return "$status"
      }
    '';
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
  };
}
