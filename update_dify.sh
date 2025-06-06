#!/bin/bash
# Dify update automation script（改良版）

set -e
set -o pipefail

# プロジェクト直下のdifyディレクトリを参照
DIFFY_DIR="./dify"
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

# dockerディレクトリのパスを再定義（カレントがdify/になるため）
DOCKER_DIR="./docker"

# 未コミットの変更を一時退避
if [[ -n $(git status --porcelain) ]]; then
    echo "ローカルに未コミットの変更があります。一時退避します…"
    git stash save "Update backup at $TIMESTAMP"
else
    echo "未コミットの変更はありません。"
fi

# 設定ファイルのバックアップ
echo "設定ファイルのバックアップを作成します…"

BACKUP_FOUND=0
for FILE in "$DOCKER_DIR/docker-compose.yaml" "$DOCKER_DIR/docker-compose.yml"; do
    if [[ -f "$FILE" ]]; then
        cp "$FILE" "$FILE$BACKUP_SUFFIX"
        echo "✔ $(basename "$FILE") → $(basename "$FILE$BACKUP_SUFFIX") にバックアップしました。"
        BACKUP_FOUND=1
    fi
done

if [[ $BACKUP_FOUND -eq 0 ]]; then
    echo "⚠ docker-compose.yaml / docker-compose.yml が見つかりません。スキップします。"
fi

# 以降の処理も相対パスで統一してください（必要に応じて追加）