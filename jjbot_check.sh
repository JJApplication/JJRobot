#!/usr/bin/env bash
# 检查git权限

source $(dirname $0)/jjbot_config.sh
# 检查密钥
if [ ! -d "$HOME/.ssh" ];then
  echo "ssh密钥不存在"
  exit 1
fi

echo "当前的公钥为:"
cat "$HOME/.ssh/id_rsa.pub"

echo "测试连通性git@github.com"
ssh -T -v "git@github.com"
