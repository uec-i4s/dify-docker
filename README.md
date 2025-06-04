## 📘 README: Dify Update Script

### 概要
このスクリプトは、Dify（自己ホスト型LLMプラットフォーム）のコードとDockerサービスを自動でアップデートするための簡易自動化ツールです。  
**バックアップ・コード更新・Docker再起動**を一括実行できます。

---

## 📂 ディレクトリ構成（例）
```
~/llm/dify/
├── dify/                  ← Dify本体（Gitクローン先）
│   └── docker/            ← Docker構成ファイル（docker-compose.yaml など）
├── update_dify.sh         ← 本スクリプト
```

---

## 🚀 使い方

1. ### スクリプトの実行権限を付与
   ```bash
   chmod +x update_dify.sh
   ```

2. ### 実行
   ```bash
   ./update_dify.sh
   ```

---

## 🔧 スクリプトの動作内容

| ステップ | 内容 |
|---|---|
| 1 | `~/llm/dify/dify` に移動し、未コミットの変更があれば `git stash` で一時退避 |
| 2 | `docker/docker-compose.yaml` と `.env` をタイムスタンプ付きでバックアップ |
| 3 | `git pull` で Dify の最新コードを取得 |
| 4 | Docker コンテナを停止 (`docker compose down`) |
| 5 | Docker コンテナを再起動 (`docker compose up -d`) |
| 6 | コンテナの状態確認 (`docker compose ps`) |

---

## 📦 バックアップファイルの命名例

- `docker-compose.yaml.1740791255.bak`
- `.env.1740791255.bak`

> 各ファイルにタイムスタンプを付加し、過去のバックアップと衝突しません。

---

## ⚠ 注意事項

- **`sudo`不要**：通常ユーザー権限で実行できます。過去に `root` で `.bak` ファイルを作成してしまった場合は、所有権を戻してください：
  ```bash
  sudo chown i4s-one:i4s-one ~/llm/dify/dify/docker/docker-compose.yaml.bak
  ```

- **バックアップファイルが増える場合**：適宜削除またはバックアップディレクトリに移動する運用を推奨。

---

## 📝 カスタマイズ例

- Volume バックアップを追加したい  
- バックアップ保存先を `$HOME/dify_backup` に変更したい  
- Slack通知など自動化フックを入れたい  

など、カスタマイズも柔軟に可能です。ご相談ください。

---

## 👨‍💻 作者
- スクリプト作成者: *あなたのお名前 or GitHubリンク*
- Dify公式: https://github.com/langgenius/dify