#!/bin/bash
set -e

VAULT="/mnt/c/Users/bpthomson/Documents/obsidian_vault"
CONTENT="$HOME/quartz/content"

echo "📂 同步 Obsidian vault → Quartz content..."
rsync -av --delete \
  --exclude '.git' \
  --exclude '.gitignore' \
  --exclude '.obsidian' \
  --exclude '.trash' \
  "$VAULT/" "$CONTENT/"

echo "✅ 同步完成"
