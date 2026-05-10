# transmail

## 概要

複数のメールアカウントから定期的に受信してGmailのアドレスに転送します。

**受信・送信のパスワードを設定するのでセキュリティに注意してください。**

## Requiement

- あなたが所有する安全なコンテナ実行環境
- 2段階認証でログインしているGmailのアカウント
- 各メールアカウントのアプリへの設定情報(POPのパスワード)

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

## インストール

### ローカルでしばらく動かして様子をみる

リポジトリをクローンしたディレクトリで

```
sh make-local-image.sh
docker compose up
```

### 安全なコンテナ実行環境のあるlinuxサーバで動かす

あなたの環境にあわせて読み替えてください。

UIDとGIDをあわせておくとよいでしょう。
```
vi make-linux-image-tar.sh
```

サーバ側でイメージを作ります。

```
sh make-linux-image-tar.sh
scp transmail.tar target.example.com:
ssh target.example.com
sudo docker load < transmail.tar
```

.env、fetchmailrc、docker-compose.yaml は既存のものをscpで上書きしないよう気をつけてください。
```
vi .env
vi ext/fetchmailrc
vi docker-compose.yaml
```

バックグラウンドで動かします
```
sudo docker compose up -d
```
