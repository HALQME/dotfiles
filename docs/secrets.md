# Secrets and key recovery

1Password is not part of the development environment. SSH authentication and Git signing use a device-local Secretive key. Project secrets use mise's age encryption with a dedicated passphrase-protected SSH key.

## SSH authentication and Git signing

Secretive stores the private key in the Secure Enclave. The private key is not backed up or restored to another Mac.

After applying the Home Manager configuration:

1. Open Secretive and create a key for GitHub.
2. Copy its public key and save it as `~/.ssh/signing.pub`.
3. Register the same public key in GitHub as both an authentication key and a signing key.
4. Create the local allowed signers file.

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh

pbpaste > ~/.ssh/signing.pub
chmod 644 ~/.ssh/signing.pub

printf '%s %s\n' \
  '68320771+HALQME@users.noreply.github.com' \
  "$(cat ~/.ssh/signing.pub)" \
  > ~/.ssh/allowed_signers
chmod 644 ~/.ssh/allowed_signers
```

Verify both authentication and signing:

```bash
ssh -T git@github.com
git commit --allow-empty -m 'test signing'
git log --show-signature -1
```

On a replacement Mac, create a new Secretive key and register the new public key in GitHub for both authentication and signing. The old private key is not migrated.

## Project secrets with mise and age

There is no global secret file in this repository. Each project stores only its own encrypted values in its own `mise.toml`.

The global mise configuration lives at `config/mise/config.toml` and is linked to `~/.config/mise/config.toml` by the shared config module. It enables direct age encryption and configures `~/.ssh/mise_age` as the dedicated SSH identity used for project secret decryption.

Create the key once, with a strong passphrase:

```bash
ssh-keygen \
  -t ed25519 \
  -a 100 \
  -f ~/.ssh/mise_age \
  -C 'mise age encryption'
```

Keep both files:

```text
~/.ssh/mise_age
~/.ssh/mise_age.pub
```

Do not add this key to GitHub. It exists only for mise secret encryption and decryption.

Add a secret from the project directory:

```bash
mise set --age-encrypt --prompt API_TOKEN
```

When no recipient is passed explicitly, mise derives an SSH recipient from the configured identity when the matching `.pub` file exists. Commit the encrypted `mise.toml`; never commit plaintext `.env` files or the private key.

## Recovery backup

`~/.ssh/mise_age` must survive a device replacement because existing project ciphertext is encrypted to its public key.

The private key remains protected by its SSH passphrase. Back up both files outside the Mac, in at least two independent locations:

```text
mise_age
mise_age.pub
```

Keep the passphrase separately from the backup files.

## New Mac recovery flow

```text
Install Nix
  -> clone dotfiles over HTTPS
  -> home-manager switch
  -> restore ~/.ssh/mise_age and ~/.ssh/mise_age.pub
  -> create a new Secretive key
  -> register the new GitHub authentication and signing keys
  -> continue using project-local encrypted secrets
```

Restore the mise key with restrictive permissions:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp /path/to/backup/mise_age ~/.ssh/mise_age
cp /path/to/backup/mise_age.pub ~/.ssh/mise_age.pub
chmod 600 ~/.ssh/mise_age
chmod 644 ~/.ssh/mise_age.pub
```

The two key lifecycles are intentionally different:

```text
Secretive key
  -> device identity
  -> rotate on device replacement
  -> do not back up

mise_age
  -> data decryption key
  -> restore on device replacement
  -> back up with passphrase protection intact
```
