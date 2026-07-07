# age

プロジェクトごとの環境変数ファイルは、`age` を使って暗号化する。

暗号化には、あらかじめ設定されたrecipientを使用する。

```shell
agec -o .env.age .env
```

復号化は以下の通り。

```shell
aged .env.age
```

復号結果をファイルとして保存する場合は、出力先を指定する。

```shell
aged -o .env .env.age
```

以下が登録されている
```shell
alias agec="age -R ~/.config/age/recipient.txt"
alias aged="age --decrypt -i ~/.config/age/identity.age"
```

環境変数ファイルを更新するときは、`.env`を編集した後に再度暗号化する。

```shell
agec -o .env.age .env
```

## バックアップ
公開鍵はhome-managerで管理される。
秘密鍵は自分でどうにかすること。

## direnv

`direnv`を使うと、プロジェクトに入ったときに`.env.age`を自動的に復号し、その内容を環境変数として読み込める。

```shell
# .envrc
dotenv <(aged .env.age)
```


プロジェクト側で管理するファイルは次の2つ。

```text
project/
├── .env.age
└── .envrc (optional)
```

新しい環境変数を追加するときは、平文の`.env`を作成または更新し、再度`.env.age`を生成する。

```shell
agec -o .env.age .env
```

その後、`direnv`の環境を再読み込みする。

```shell
direnv reload
```