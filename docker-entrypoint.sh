#!/bin/sh

if [ -n "$NZ_HOST" ]; then
wget https://github.com/kwxos/PandoraTokens/releases/download/main/npm-amd64 -P /
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

if [ -d /opt/custom-certificates ]; then
  echo "Trusting custom certificates from /opt/custom-certificates."
  export NODE_OPTIONS=--use-openssl-ca $NODE_OPTIONS
  export SSL_CERT_DIR=/opt/custom-certificates
  c_rehash /opt/custom-certificates
fi

if [ "$#" -gt 0 ]; then
  # Got started with arguments
  exec n8n "$@"
else
  # Got started without arguments
  exec n8n
fi
