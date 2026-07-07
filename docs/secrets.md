# SSH鍵とGit署名

GitHubへのSSH認証とGit署名にはSecretiveを使用する。

```text
Secretive
  -> GitHub SSH Authentication
  -> Git Signing
```

Secretiveの公開鍵パスは端末ごとに異なるため、署名設定は`hosts/macbook/git.nix`で管理する。

## 初回セットアップ

1. Home Managerの設定を適用する。
2. Secretiveを開き、GitHub用の鍵を作成する。
3. 同じ公開鍵をGitHubへAuthentication keyとSigning keyとして登録する。
4. Secretiveの公開鍵パスを`hosts/macbook/git.nix`の`signingKey`に設定する。
5. もう一度Home Managerの設定を適用する。

```bash
home-manager switch
```

`hosts/macbook/git.nix`から、次のGit設定を生成する。

```ini
[user]
    signingkey = $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/<key>.pub
[commit]
    gpgsign = true
[gpg]
    format = ssh
[gpg "ssh"]
    allowedSignersFile = ~/.ssh/allowed_signers
```

同時に、指定した公開鍵から`~/.ssh/allowed_signers`を生成する。

SSH認証を確認する。

```bash
ssh -T git@github.com
```

Git署名を確認する。

```bash
git commit --allow-empty -m 'test signing'
git log --show-signature -1
```

## 新しいMacへの移行

1. Nixをインストールする。
2. dotfilesをHTTPSでcloneする。
3. Home Managerの設定を適用する。
4. Secretiveで新しいGitHub用の鍵を作成する。
5. 同じ公開鍵をGitHubへAuthentication keyとSigning keyとして登録する。
6. Secretiveの公開鍵パスを、その端末のhost設定に反映する。
7. もう一度Home Managerの設定を適用する。
8. SSH認証とGit署名を確認する。

```text
Nixをインストール
  -> dotfilesをHTTPSでclone
  -> home-manager switch
  -> Secretiveで鍵を生成
  -> GitHubへAuthentication keyとSigning keyとして登録
  -> host設定へ公開鍵パスを反映
  -> home-manager switch
  -> SSH認証とGit署名を確認
```
