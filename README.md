# transmail

## 概要

複数のメールアカウントから定期的に受信して集約先のアドレスに転送します。

**受信・送信のパスワードを設定するのでセキュリティに充分注意してください。**

## 必要なもの

- あなたが所有する安全なコンテナ実行環境
- SPF/DKIM/DMARC 対応済みドメインで動くSMTPサーバー
  - 2段階認証を設定したGmailのアカウントで代替できるが副作用あり
- 各メールアカウントのアプリへの設定情報(POPサーバやパスワードなど)

### 前提

受信したメールはもとのアカウントには残しません。

## 設定

受信のための設定ファイル、送信のための環境ファイルがあります。
それぞれサンプルをコピーして書き換えるとよいでしょう。
どちらもパーミッションに気をつけてください。

```
mkdir -p ext
cp fetchmailrc.example ext/fetchmailrc
chmod 600 ext/fetchmailrc
vi ext/fetchmailrc
```

```
cp env.example .env
chmod 600 .env
vi .env
```

## インストールと実行

### ローカルでしばらく動かして様子をみる

リポジトリをクローンしたディレクトリで

```
sh make-local-image.sh
docker compose up
```

### 安全なコンテナ実行環境のあるlinuxサーバで動かす

あなたの環境にあわせて読み替えてください。

サーバ用のイメージを作って持ち込みます。
```
sh make-linux-image-tar.sh
scp transmail.tar target.example.com:
ssh target.example.com
sudo docker load < transmail.tar
```

.env、docker-compose.yaml は既存のものをscpで上書きしないよう気をつけましょう。
なお作者の場合 volumes は `- ./vol/コンテナ名:/ext` でマウントしています。
```
vi .env
vi docker-compose.yaml

mkdir -p vol/transmail
vi vol/transmail/fetchmailrc
```

バックグラウンドで動かします。
```
sudo docker compose up -d
```
