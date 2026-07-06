# Secrets and key recovery

1Password is not part of the development environment. SSH authentication and Git signing use a device-local Secretive key, while project secrets use mise's age encryption.

## SSH authentication and Git signing

Secretive stores the private key in the Secure Enclave. The private key is intentionally not backed up or restored to another Mac.

After applying the Home Manager configuration:

1. Open Secretive and create a key for GitHub.
2. Copy its public key and save it as `~/.ssh/signing.pub`.
3. Register the public key in GitHub for SSH authentication and signing.
4. Create the local allowed signers file.

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copy the public key in Secretive, then:
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

On a replacement Mac, create a new Secretive key and replace the old key in GitHub. Do not attempt to migrate the private key.

## Project secrets with mise and age

There is no global secret file in this repository. Each project stores only its own encrypted values in its own `mise.toml`.

The global mise configuration lives at `config/mise/config.toml` and is linked to `~/.config/mise/config.toml` by the shared config module. It enables the experimental features required for direct age encryption.

Create the age identity the first time a project needs encrypted secrets:

```bash
mkdir -p ~/.config/mise
age-keygen -o ~/.config/mise/age.txt
chmod 600 ~/.config/mise/age.txt
```

Add a secret from the project directory:

```bash
mise set --age-encrypt --prompt API_TOKEN
```

Commit the encrypted `mise.toml`; never commit plaintext `.env` files or the age identity. mise performs encryption and decryption itself; the `age` CLI is installed for identity generation and recovery.

## Recovery backup

The age identity is the only secret material that must survive a device replacement. Keep a passphrase-encrypted backup outside the Mac.

```bash
age -p \
  -o mise-age-recovery.txt.age \
  ~/.config/mise/age.txt
```

Store the encrypted recovery file in at least two independent locations, for example cloud storage and removable media. Keep the passphrase separately from the recovery file.

## New Mac recovery flow

Bootstrap does not depend on any secret:

```text
Install Nix
  -> clone dotfiles over HTTPS
  -> home-manager switch
  -> restore the age identity
  -> create a new Secretive key
  -> register the new GitHub keys
  -> continue using project-local encrypted secrets
```

Restore the age identity:

```bash
mkdir -p ~/.config/mise
age -d \
  -o ~/.config/mise/age.txt \
  mise-age-recovery.txt.age
chmod 600 ~/.config/mise/age.txt
```

The Git/SSH key is rotated on every device migration. The age identity is restored because existing project ciphertext must remain decryptable.
