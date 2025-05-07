#!/bin/bash

BUCKET_NAME="name"
BINARY_PATH="binario/bin"
BINARY_NAME=$(basename "$BINARY_PATH")

aws s3 cp s3://$BUCKET_NAME/$BINARY_PATH /home/ec2-user/

chmod +x /home/ec2-user/$BINARY_NAME

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