## Dify Docker セットアップツール

Difyプラットフォームの自動セットアップとアップデートを行うスクリプト集。
初回セットアップから継続的なアップデートまでを自動化します。

## ディレクトリ構成

```
dify-docker/
├── dify/                ← Dify本体（自動クローン先）
│   └── docker/          ← Docker構成ファイル
├── start_dify.sh        ← 初回セットアップ・起動スクリプト
├── update_dify.sh       ← アップデート・バックアップスクリプト
├── .gitignore
└── README.md
```

## 使用方法

### 1. 実行権限の付与

```bash
chmod +x start_dify.sh update_dify.sh
```

### 2. 初回セットアップ・起動

```bash
./start_dify.sh
```

最新リリースのDifyを自動クローンし、Docker環境を構築・起動します。
Dockerへのアクセス権限が必要です。

### 3. アップデート

```bash
./update_dify.sh
```

設定ファイルをバックアップし、最新コードを取得してDockerコンテナを再起動します。

## スクリプト動作詳細

### start_dify.sh
- GitHub APIから最新リリースを取得し自動クローン
- 設定ファイル（.env）の自動生成
- Docker環境の構築・起動
- コンテナ状態の確認

### update_dify.sh
- 未コミット変更の一時退避
- 設定ファイルのタイムスタンプ付きバックアップ
- 最新コードの取得（git pull）
- Dockerコンテナの再起動

## 必要環境

- Docker & Docker Compose
- Git
- curl（GitHub API使用）
- Bashシェル

## 注意事項

- `dify/`ディレクトリは管理対象外（.gitignore設定済み）
- プロジェクトルート（dify-docker/）で実行すること
- Dockerデーモンへの適切なアクセス権限が必要

## 参考リンク

- [Dify公式リポジトリ](https://github.com/langgenius/dify)
- [Docker公式ドキュメント](https://docs.docker.com/)

## ライセンス

MIT License