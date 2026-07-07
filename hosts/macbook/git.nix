{config, lib, ...}: let
  gitEmail = config.programs.git.settings.user.email;
  signingKey = "${config.home.homeDirectory}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/6057ce14894fb07471677b81fb3d0f33.pub";
in {
  programs.git.settings = {
    user.signingkey = signingKey;
    commit.gpgsign = true;
    gpg.format = "ssh";
    "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";
  };

  home.activation.configureAllowedSigners = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f '${signingKey}' ]; then
      mkdir -p "$HOME/.ssh"
      printf '%s %s\n' '${gitEmail}' "$(cat '${signingKey}')" > "$HOME/.ssh/allowed_signers"
      chmod 644 "$HOME/.ssh/allowed_signers"
    else
      rm -f "$HOME/.ssh/allowed_signers"
    fi
  '';
}
