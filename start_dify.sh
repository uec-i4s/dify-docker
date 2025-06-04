#!/bin/bash
set -e

# Dify docker ディレクトリへ移動
if [ ! -d "dify/docker" ]; then
  echo "dify/docker ディレクトリが見つかりません。dify のクローンが必要です。"
  echo "例: git clone https://github.com/langgenius/dify.git --branch 0.15.3"
  exit 1
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