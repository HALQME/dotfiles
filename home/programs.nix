{
  programs.bat.enable = true;
  
  programs.bottom.enable = true;
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  
  programs.eza.enable = true;
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.jujutsu.enable = true;
  
  programs.lazygit.enable = true;
  
  programs.neovim.enable = true;
  
  programs.nix-index.enable = true;
  
  programs.ripgrep.enable = true;
  
  programs.tmux.enable = true;
  
  programs.zellij.enable = true;
  
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
