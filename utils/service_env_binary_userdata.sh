#!/bin/bash

WORKPATH="/home/ec2-user"

# Nome do arquivo de conf
CONFIG_FILE_NAME="server.ini"

# Bucket onde está o binario
BUCKET_NAME="name"

# Caminho de onde esta o binario
BINARY_PATH="binario/bin"

BINARY_NAME=$(basename "$BINARY_PATH")

aws s3 cp s3://$BUCKET_NAME/$BINARY_PATH $WORKPATH/

chmod +x $WORKPATH/$BINARY_NAME

touch $WORKPATH/$CONFIG_FILE_NAME

# DEFINIR ENVS AQUI

echo '"MemcacheHost"="host"' >> $WORKPATH/server.ini
echo '"MemcachePort"=0000' >> $WORKPATH/server.ini
echo '"LogsPath"="./"' >> $WORKPATH/server.ini

cat > /etc/systemd/system/ws-server.service << EOF
[Unit]
Description=WS Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/home/ec2-user
ExecStart=/home/ec2-user/$BINARY_NAME
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ws-server
systemctl start ws-server