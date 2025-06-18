#!/usr/bin/env bash
set -eux

echo
echo "Publishing ARM64 images, Repo: $1, Tag: $2"
echo

# 默认使用 ARM64 架构构建
PLATFORM="linux/arm64"

for dir in ts-*; do
    if [[ -d $dir ]]; then
        if [[ -n $(ls "$dir" | grep -i Dockerfile) ]]; then
            echo "Building ${dir} for platform ${PLATFORM}"

            # 使用 buildx 构建并推送 ARM64 镜像
            docker buildx build \
              --platform "${PLATFORM}" \
              --push \
              -t "$1/${dir}:$2" \
              "$dir"
        fi
    fi
done
