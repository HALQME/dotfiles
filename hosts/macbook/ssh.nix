{...}: let
  secretiveAgentSocket = "~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [
      "~/.orbstack/ssh/config"
    ];

    settings."*" = {
      Compression = false;
      ForwardAgent = false;
      HashKnownHosts = true;
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
      IdentityAgent = secretiveAgentSocket;
    };
  };

  home.file.".ssh/config".force = true;
}
