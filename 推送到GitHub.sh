#!/bin/bash
# 把本地 main 分支推送到 GitHub（SSH 方式，需本机 SSH key 已绑定 GitHub 账号）
set -e
cd "$(dirname "$0")"

echo "=== 当前分支与改动 ==="
git branch --show-current
git status --short
echo "=== 远程仓库 ==="
git remote -v
echo "=== 开始推送 ==="

if git push origin main; then
  echo ""
  echo "推送成功：https://github.com/shishugen/llm-exam-paper-generator"
else
  echo ""
  echo "推送失败，按常见原因排查："
  echo "1) SSH 认证失败：用 ssh -T git@github.com 验证本机密钥是否已添加到 GitHub 账号。"
  echo "2) 远程有本地没有的提交：先 git pull --rebase origin main 再重试。"
  echo "3) 网络不通：确认能连上 github.com 的 22 端口。"
  exit 1
fi
