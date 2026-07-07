# 秘密情報と鍵の復旧

この環境では、用途ごとに鍵のライフサイクルを分離する。

```text
GitHubへのSSH認証・Git署名
  -> Secretive
  -> 端末ごとに生成

miseのproject secret
  -> ~/.ssh/mise_age
  -> パスフレーズ付きSSH鍵
  -> 端末移行時に同じ鍵を復元する
```

## GitHubへのSSH認証とGit署名

Secretiveは秘密鍵をSecure Enclaveに保存する。端末ごとにGitHub用の鍵を生成する。

Home Managerの設定を適用した後、次の手順でセットアップする。

1. Secretiveを開き、GitHub用の鍵を作成する。
2. 公開鍵をコピーし、`~/.ssh/signing.pub`として保存する。
3. 同じ公開鍵をGitHubへAuthentication keyとSigning keyの両方として登録する。
4. ローカルの`allowed_signers`を作成する。

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

SSH認証と署名を確認する。

```bash
ssh -T git@github.com
git commit --allow-empty -m 'test signing'
git log --show-signature -1
```

新しいMacへ移行するときは、新しいSecretive鍵を生成し、その公開鍵をGitHubへAuthentication keyとSigning keyとして登録する。

## miseによるproject secretの暗号化

各projectは、自分の`mise.toml`にそのproject専用の暗号化済みsecretを保存する。

グローバルなmise設定は`config/mise/config.toml`に置き、共通config moduleから`~/.config/mise/config.toml`へリンクする。

この設定では、miseのdirect age encryptionを有効にし、`~/.ssh/mise_age`をproject secretの暗号化・復号専用SSH鍵として使用する。

```toml
[settings]
experimental = true

[settings.age]
ssh_identity_files = ["~/.ssh/mise_age"]
```

### 初回セットアップ

`mise_age`は一度だけ作成する。パスフレーズを設定する。

```bash
ssh-keygen \
  -t ed25519 \
  -a 100 \
  -f ~/.ssh/mise_age \
  -C 'mise age encryption'
```

生成されるファイルは次の2つ。

```text
~/.ssh/mise_age      # パスフレーズ付き秘密鍵
~/.ssh/mise_age.pub  # 公開鍵
```

project内でsecretを追加する。

```bash
mise set --age-encrypt --prompt API_TOKEN
```

暗号化済みの`mise.toml`をGitへcommitする。

## mise_ageのバックアップ

`~/.ssh/mise_age`は、既存のproject secretを復号するための長期鍵である。新しいMacへ移行しても同じ鍵を使うため、生成直後にバックアップする。

秘密鍵はSSH鍵のパスフレーズで暗号化された状態のままコピーする。

推奨する保管先は次の2系統。

```text
クラウドストレージ
└── Recovery/mise/
    ├── mise_age
    └── mise_age.pub

USBメモリまたは外部SSD
└── Recovery/mise/
    ├── mise_age
    └── mise_age.pub
```

Mac本体とは独立した2箇所に保存する。

パスフレーズは紙などの別経路で復元できる場所に保管する。

### バックアップ例

クラウドストレージ上の`Recovery/mise`へコピーする。

```bash
mkdir -p /path/to/cloud-storage/Recovery/mise
cp ~/.ssh/mise_age /path/to/cloud-storage/Recovery/mise/mise_age
cp ~/.ssh/mise_age.pub /path/to/cloud-storage/Recovery/mise/mise_age.pub
```

同じ2ファイルを、USBメモリまたは外部SSDにもコピーする。

`mise_age.pub`は秘密鍵から再生成できる。復旧を単純にするため、通常は両方をバックアップする。

## 新しいMacへの復旧

復旧の流れは次の通り。

```text
Nixをインストール
  -> dotfilesをHTTPSでclone
  -> home-manager switch
  -> バックアップからmise_ageを復元
  -> Secretiveで新しいGitHub用鍵を生成
  -> GitHubへAuthentication keyとSigning keyとして登録
  -> projectをclone
  -> 既存の暗号化済みsecretを復号
```

### mise_ageの復元

クラウドストレージまたは外部メディアから、同じ`mise_age`を新しいMacへ戻す。

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh

cp /path/to/backup/mise_age ~/.ssh/mise_age
cp /path/to/backup/mise_age.pub ~/.ssh/mise_age.pub

chmod 600 ~/.ssh/mise_age
chmod 644 ~/.ssh/mise_age.pub
```

`mise_age.pub`は秘密鍵から再生成できる。

```bash
ssh-keygen -y -f ~/.ssh/mise_age > ~/.ssh/mise_age.pub
chmod 644 ~/.ssh/mise_age.pub
```

復元後は、既存projectで暗号化済みsecretを読み出せることを確認する。

## 鍵のライフサイクル

```text
Secretive鍵
  -> 端末のidentity
  -> 端末移行時に新規生成

mise_age
  -> project secretの復号鍵
  -> 端末移行時に同じ鍵を復元
  -> パスフレーズ保護を維持したままバックアップする
```
