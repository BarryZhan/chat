#!/bin/bash

set -e

echo "开始构建..."

# 安装依赖
yarn install

# 构建项目
yarn build

# 清理并创建 dist 目录
rm -rf dist
mkdir -p dist

echo "复制文件..."

# 复制 standalone 构建文件
cp -r .next/standalone/* dist/

# 复制静态文件和服务端文件
mkdir -p dist/.next
cp -r .next/static dist/.next/static
cp -r .next/server dist/.next/server

# 复制 public 文件
cp -r public dist/

# 复制 MCP 配置
if [ -d "app/mcp" ]; then
    mkdir -p dist/app/mcp
    cp -r app/mcp/* dist/app/mcp/
fi

# 复制环境变量文件
[ -f ".env" ] && cp .env dist/

echo "构建完成！文件在 dist 目录中"
echo "使用方法: cd dist && node server.js"