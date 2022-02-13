#!/usr/bin/env bash
# 生成ssh签名密钥
# 如果系统已经存在则先删除

if [ -d "$HOME/.ssh" ];then
  echo ".ssh已经存在"
fi

echo "开始生成密钥"
ssh-keygen -t rsa