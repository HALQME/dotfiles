# SSH鍵とGit署名

GitHubへのSSH認証とGit署名にはSecretiveを使用する。

```text
Secretive
  -> GitHub SSH Authentication
  -> Git Signing
```

Secretiveの公開鍵パスは端末ごとに異なるため、署名設定は `hosts/<hostname>/git.nix` で管理する。SSH設定は `hosts/<hostname>/ssh.nix` で管理する。

## 初回セットアップ

1. mise bootstrap を適用する。
2. home-manager を適用する。
3. Secretiveを開き、GitHub用の鍵を作成する。
4. 同じ公開鍵をGitHubへAuthentication keyとSigning keyとして登録する。
5. Secretiveの公開鍵パスを `hosts/<hostname>/git.nix` の `signingKey` に設定する。
6. もう一度 home-manager を適用する。

```bash
cd ~/.dotfiles
mise bootstrap --yes
home-manager switch --flake .#hal@$(hostname -s).local
```

home-manager が次の Git 設定を生成する。

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

同時に、指定した公開鍵から `~/.ssh/allowed_signers` を生成する。

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

1. mise と Nix をインストールする。
2. dotfilesをHTTPSでcloneする。
3. `hosts/<hostname>/` を追加し、`flake.nix` にホスト定義を書く。
4. mise bootstrap を適用する。
5. home-manager を適用する。
6. Secretiveで新しいGitHub用の鍵を作成する。
7. 同じ公開鍵をGitHubへAuthentication keyとSigning keyとして登録する。
8. `hosts/<hostname>/git.nix` の `signingKey` を更新する。
9. もう一度 home-manager を適用する。
10. SSH認証とGit署名を確認する。

```text
mise + Nixをインストール
  -> dotfilesをHTTPSでclone
  -> hosts/<hostname>/ を追加
  -> mise bootstrap --yes
  -> home-manager switch
  -> Secretiveで鍵を生成
  -> GitHubへAuthentication keyとSigning keyとして登録
  -> hosts/<hostname>/git.nix を更新
  -> home-manager switch
  -> SSH認証とGit署名を確認
```

## 注意事項
Secretiveを使用している場合、コミットを行うアプリ（ターミナルエミュレータ、エディタ）にはフルディスクアクセスが必要になります
