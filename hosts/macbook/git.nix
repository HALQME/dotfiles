{config, lib, ...}: let
  gitEmail = "68320771+HALQME@users.noreply.github.com";
  secretivePublicKeysDir = "${config.home.homeDirectory}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys";
  hostGitConfig = "${config.xdg.configHome}/git/host-signing.conf";
in {
  programs.git.includes = [
    {path = hostGitConfig;}
  ];

  home.activation.configureSecretiveGitSigning = lib.hm.dag.entryAfter ["writeBoundary"] ''
    public_key="$(${lib.getExe' config.programs.git.package "git"} config --global --get user.signingkey 2>/dev/null || true)"

    if [ -z "$public_key" ] || [ ! -f "$public_key" ]; then
      public_key="$(find '${secretivePublicKeysDir}' -maxdepth 1 -type f -name '*.pub' -print -quit 2>/dev/null || true)"
    fi

    if [ -z "$public_key" ]; then
      echo "Secretive public key not found; skipping Git signing configuration"
      exit 0
    fi

    mkdir -p "$(dirname '${hostGitConfig}')" "$HOME/.ssh"

    cat > '${hostGitConfig}' <<EOF
[user]
    signingkey = $public_key
[commit]
    gpgsign = true
[gpg]
    format = ssh
[gpg "ssh"]
    allowedSignersFile = ~/.ssh/allowed_signers
EOF

    printf '%s %s\n' '${gitEmail}' "$(cat "$public_key")" > "$HOME/.ssh/allowed_signers"
    chmod 644 "$HOME/.ssh/allowed_signers"
  '';
}
