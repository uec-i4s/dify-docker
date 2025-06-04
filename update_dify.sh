#!/bin/bash
# Dify update automation script（改良版）

set -e
set -o pipefail

# 環境に合わせたディレクトリパスを設定
DIFFY_DIR="$HOME/llm/dify/dify"
DOCKER_DIR="$DIFFY_DIR/docker"
TIMESTAMP=$(date +%s)
BACKUP_SUFFIX=".$TIMESTAMP.bak"

echo "=== Difyのアップデートを開始します ==="

# dify ディレクトリの存在チェック
if [[ ! -d "$DIFFY_DIR" ]]; then
    echo "エラー: ディレクトリ $DIFFY_DIR が存在しません。"
    exit 1
fi

# difyディレクトリに移動
cd "$DIFFY_DIR"

# 未コミットの変更を一時退避
if [[ -n $(git status --porcelain) ]]; then
    echo "ローカルに未コミットの変更があります。一時退避します…"
    git stash save "Update backup at $TIMESTAMP"
else
    echo "未コミットの変更はありません。"
fi

# 設定ファイルのバックアップ
echo "設定ファイルのバックアップを作成します…"

if [[ -f "$DOCKER_DIR/docker-compose.yaml" ]]; then
    cp "$DOCKER_DIR/docker-compose.yaml" "$DOCKER_DIR/docker-compose.yaml$BACKUP_SUFFIX"
    echo "✔ docker-compose.yaml → docker-compose.yaml$BACKUP_SUFFIX にバックアップしました。"
else
    echo "⚠ docker-compose.yaml が見つかりません。スキップします。"
fi

if [[ -f "$DOCKER_DIR/.env" ]]; then
    cp "$DOCKER_DIR/.env" "$DOCKER_DIR/.env$BACKUP_SUFFIX"
    echo "✔ .env → .env$BACKUP_SUFFIX にバックアップしました。"
else
    echo "⚠ .env が見つかりません。スキップします。"
fi

# 最新コードの取得
echo "Gitから最新コードを取得します…"
git checkout main
git pull origin main

# Dockerサービス停止
echo "Difyサービスを停止します…"
cd "$DOCKER_DIR"
docker compose down

# 必要に応じて設定ファイルの変更を手動確認…

# Dockerサービス再起動
echo "Difyサービスを再起動します…"
docker compose up -d

# コンテナ状態確認
sleep 10
echo "=== コンテナの状態を確認 ==="
docker compose ps

echo "🎉 Difyのアップデートが完了しました！"