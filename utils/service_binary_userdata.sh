#!/bin/bash

cat > /etc/systemd/system/ws-server.service << 'EOF'
[Unit]
Description=WS Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/home/ec2-user/binario
ExecStart=/home/ec2-user/binario/bin
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ws-server
systemctl start ws-server