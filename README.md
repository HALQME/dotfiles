# dotfiles (mise + home-manager)

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) と [home-manager](https://github.com/nix-community/home-manager) のハイブリッド構成です。

| 担当 | 内容 |
|------|------|
| **mise** | 静的 dotfiles（symlink）、`[bootstrap.packages]`（brew/apt）、タスク |
| **home-manager** | git / ssh / direnv の生成、端末依存設定、Nix 文脈ツール |

ランタイムのバージョン管理（`[tools]`）はプロジェクト単位の `.mise.toml` で行う。グローバル CLI は brew/apt 経由。

Zsh の入口ファイル（`~/.zprofile` / `~/.zshrc`）は mise の marker block で管理する。`zprofile` には shims、`zshrc` にはディレクトリ移動時の環境更新を有効化し、実際の設定は `~/.config/zsh/{zprofile,zshrc}.zsh` から読み込む。これにより、mise が shell activation を更新しても他の shell 設定を上書きしない。

## 構成

- `config/`: 静的ドットファイル（Zsh, Tmux, Neovim, Ghostty 等）
- `mise/`: mise のグローバル設定
- `profiles/hal/`, `hosts/`: home-manager（生成系のみ）
- `scripts/`: 補助スクリプト

## セットアップ

### 1. mise のインストール

```bash
curl https://mise.run | sh
```

### 2. Nix / home-manager の準備

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

### 3. リポジトリのクローン

```bash
git clone https://github.com/HALQME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 4. 設定の適用

```bash
# パッケージ + 静的 dotfiles
mise trust
MISE_CONFIG_FILE=~/.dotfiles/mise/config.toml mise bootstrap --yes

# 端末依存 config + Nix ツール（git/ssh/direnv, comma, nix-index）
home-manager switch --flake ~/.dotfiles#hal@$(hostname -s).local
```

ホスト名が flake に無い場合は明示指定:

```bash
home-manager switch --flake ~/.dotfiles#hal@MacBook-Pro.local
```

### 5. 更新

```bash
cd ~/.dotfiles && git pull
mise bootstrap --yes
home-manager switch --flake .#hal@$(hostname -s).local
```

### 6. macOS パッケージの更新
formulaはmise側で、caskはBrewfileで行う。

### 7. 手動セットアップ

SSH鍵、Git署名、端末移行時の手順は [`docs/git&verify.md`](docs/git&verify.md) を参照。

## 新しい Mac を追加するとき

1. `hosts/<hostname>/` を作成（`macbook/` をコピーしてよい）
2. `hosts/<hostname>/git.nix` の `signingKey` を Secretive の公開鍵パスに更新
3. `flake.nix` の `homeDefinitions` に `hal@<hostname>.local` を追加
4. `mise bootstrap --yes` → `home-manager switch --flake .#hal@<hostname>.local`

## CI 向け (Linux)

```bash
home-manager switch --flake .#ci@actions
MISE_CONFIG_FILE=~/.dotfiles/mise/config.toml mise bootstrap --yes --skip macos-defaults,macos-launchd-agents
```
