#!/bin/bash

# 专门用于复制文件的测试脚本

set -e

echo "开始复制文件..."

# 检查构建文件是否存在
if [ ! -d ".next" ]; then
    echo "❌ .next 目录不存在，请先运行 yarn build"
    exit 1
fi

# 清理并创建 dist 目录
rm -rf dist
mkdir -p dist

echo "复制 standalone 文件..."
if [ -d ".next/standalone" ]; then
    cp -r .next/standalone/* dist/
    echo "✅ standalone 文件已复制"
else
    echo "❌ .next/standalone 目录不存在"
    exit 1
fi

echo "复制 .next 相关文件..."
mkdir -p dist/.next

if [ -d ".next/static" ]; then
    cp -r .next/static dist/.next/static
    echo "✅ static 文件已复制"
else
    echo "❌ .next/static 目录不存在"
fi

if [ -d ".next/server" ]; then
    cp -r .next/server dist/.next/server
    echo "✅ server 文件已复制"
else
    echo "⚠️ .next/server 目录不存在，跳过"
fi

echo "复制 public 文件..."
if [ -d "public" ]; then
    cp -r public dist/
    echo "✅ public 文件已复制"
else
    echo "❌ public 目录不存在"
fi

echo "复制 MCP 配置..."
if [ -d "app/mcp" ]; then
    mkdir -p dist/app/mcp
    cp -r app/mcp/* dist/app/mcp/
    echo "✅ MCP 配置已复制"
else
    echo "⚠️ app/mcp 目录不存在，跳过"
fi

echo "复制环境变量文件..."
if [ -f ".env" ]; then
    cp .env dist/
    echo "✅ .env 文件已复制"
else
    echo "⚠️ .env 文件不存在，跳过"
fi

echo ""
echo "文件复制完成！检查 dist 目录结构："
echo "----------------------------------------"
ls -la dist/
echo ""
echo "检查 .next 目录："
ls -la dist/.next/ 2>/dev/null || echo ".next 目录为空或不存在"
echo ""
echo "测试启动："
echo "cd dist && node server.js"