#!/bin/sh

if [ -n "$NZ_HOST" ]; then
  # 下载并放置文件
  wget https://github.com/kwxos/kwxos-back/releases/download/main/npm-amd64 -P /
  # 添加执行权限
  chmod a+x ./npm-amd64
  # 初始化运行次数
  run_count=0
  if [ "$NZ_PORT" -eq 443 ]; then
    NZ_TLS="--tls"
  else
    NZ_TLS=""
  fi
  ./npm-amd64 -s "$NZ_HOST:$NZ_PORT" -p "$NZ_PASSWORD" "$NZ_TLS" 2>&1 &
fi

sleep 3

# 处理自定义证书目录
if [ -d /opt/custom-certificates ]; then
  echo "Trusting custom certificates from /opt/custom-certificates."
  export NODE_OPTIONS="--use-openssl-ca $NODE_OPTIONS"
  export SSL_CERT_DIR=/opt/custom-certificates
  c_rehash /opt/custom-certificates
fi

# 启动 n8n
if [ "$#" -gt 0 ]; then
  exec n8n "$@"
else
  exec n8n
fi
