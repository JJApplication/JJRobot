#!/usr/bin/env bash
# 初始化仓库使用

source $(dirname $0)/jjbot_config.sh

cd "$APP_ROOT" || exit
echo "当前APP目录$APP_ROOT: 开始clone仓库$GIT_REMOTE"
git clone "$GIT_REMOTE"