# 🐳 Dify Docker 自動化ツール

Dify（自己ホスト型LLMプラットフォーム）のDocker環境を簡単にセットアップ・運用するための自動化スクリプト集です。

## 📋 概要

このプロジェクトでは、Difyの**初期セットアップ**から**日常的なアップデート**まで、Dockerを使った運用を自動化します。

### 🛠 提供スクリプト
- **`start_dify.sh`** - 初回セットアップ・起動スクリプト
- **`update_dify.sh`** - アップデート・再起動スクリプト

---

## 🚀 初回セットアップ

### 1. リポジトリのクローン
```bash
git clone https://github.com/uec-i4s/dify-docker.git
cd dify-docker
```

### 2. 初回起動
```bash
chmod +x start_dify.sh
./start_dify.sh
```

### 📂 セットアップ後のディレクトリ構成
```
dify-docker/
├── dify/                  ← Dify本体（自動クローン）
│   └── docker/            ← Docker構成ファイル
│       ├── docker-compose.yaml
│       └── .env           ← 環境設定ファイル
├── start_dify.sh          ← 初回セットアップスクリプト
└── update_dify.sh         ← アップデートスクリプト
```

---

## 🔄 日常的なアップデート

### アップデートの実行
```bash
chmod +x update_dify.sh
./update_dify.sh
```

### 🔧 アップデートスクリプトの動作内容

| ステップ | 内容 |
|---|---|
| 1 | `dify/` ディレクトリに移動し、未コミットの変更を `git stash` で一時退避 |
| 2 | `docker-compose.yaml` と `.env` をタイムスタンプ付きでバックアップ |
| 3 | `git pull` で Dify の最新コードを取得 |
| 4 | Docker コンテナを停止・再起動 |
| 5 | コンテナの状態確認 |

---

## 🛡 安全機能

### バックアップ機能
設定ファイルは自動的にタイムスタンプ付きでバックアップされます：
- `docker-compose.yaml.1740791255.bak`
- `.env.1740791255.bak`

### Docker Compose バージョン対応
Docker Compose V1/V2 の両方に自動対応します。

---

## 📋 動作要件

- **Docker**: Docker Engine がインストール済み
- **Docker Compose**: V1 または V2
- **Git**: リポジトリ操作用
- **curl**: 最新リリース情報取得用
- **インターネット接続**: GitHub API アクセス用

---

## ⚙️ 設定のカスタマイズ

### 環境変数の編集
```bash
cd dify/docker
nano .env
```

### Docker Compose 設定の変更
```bash
cd dify/docker  
nano docker-compose.yaml
```

---

## 🔍 トラブルシューティング

### よくある問題

#### 権限エラー
```bash
# バックアップファイルの所有権修正
sudo chown $USER:$USER ~/path/to/backup/files/*.bak
```

#### コンテナが起動しない
```bash
# ログの確認
cd dify/docker
docker compose logs
```

#### 過去の状態に戻したい
```bash
# バックアップから復元
cd dify/docker
cp docker-compose.yaml.TIMESTAMP.bak docker-compose.yaml
cp .env.TIMESTAMP.bak .env
docker compose up -d
```

---

## 🔗 関連リンク

- **Dify公式リポジトリ**: https://github.com/langgenius/dify
- **Dify公式ドキュメント**: https://docs.dify.ai/
- **Docker公式サイト**: https://www.docker.com/

---

## 📄 ライセンス

このプロジェクトは個人・組織での自由な利用を想定しています。  
Dify本体については、[公式ライセンス](https://github.com/langgenius/dify/blob/main/LICENSE)をご確認ください。