#!/bin/bash
set -e

# Difyリポジトリのクローン（最新リリース取得）
if [ ! -d "dify/docker" ]; then
  echo "dify/docker ディレクトリが見つかりません。最新バージョンを取得してクローンします。"
  # GitHub APIから最新リリースのタグ名を取得
  LATEST_TAG=$(curl -s https://api.github.com/repos/langgenius/dify/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  if [ -z "$LATEST_TAG" ]; then
    echo "最新リリースの取得に失敗しました。"
    exit 1
  fi
  echo "最新バージョン: $LATEST_TAG"
  git clone https://github.com/langgenius/dify.git --branch "$LATEST_TAG"
fi

cd dify/docker

# .env がなければ .env.example をコピー
if [ ! -f ".env" ]; then
  if [ -f ".env.example" ]; then
    echo ".env ファイルが見つかりません。.env.example からコピーします。"
    cp .env.example .env
  else
    echo ".env.example ファイルが見つかりません。"
    exit 1
  fi
fi

# docker compose バージョン判定
if docker compose version &>/dev/null; then
  # Docker Compose V2
  echo "Docker Compose V2 を検出しました。コンテナを起動します。"
  docker compose up -d
  echo "コンテナの状態:"
  docker compose ps
elif docker-compose version &>/dev/null; then
  # Docker Compose V1
  echo "Docker Compose V1 を検出しました。コンテナを起動します。"
  docker-compose up -d
  echo "コンテナの状態:"
  docker-compose ps
else
  echo "docker compose または docker-compose がインストールされていません。"
  exit 1
fi

echo "Dify の起動が完了しました。"