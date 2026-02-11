{
  programs.git = {
    enable = true;

    userName = "HALQME";
    userEmail = "example@example.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
