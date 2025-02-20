# Criar o arquivo do serviço

sudo nano /etc/systemd/system/meu_binario.service

# Configuração basica

[Unit]
Description=Binário
After=network.target

[Service]
ExecStart=/home/ec2-user/meu_binario 
Restart=always
User=root
EnvironmentFile=/home/ec2-user/binario.env
WorkingDirectory=/home/ec2-user/

# Se o binario tiver flag, fazer isso:
#
# ExecStart=/home/ec2-user/meu_binario --flag=VALOR

[Install]
WantedBy=multi-user.target

# Reiniciar os serviços

sudo systemctl daemon-reload

# Habilitar o serviço para inicar sozinho

sudo systemctl enable meu_binario.service

# Iniciar

sudo systemctl start meu_binario.service

# Visualizar os logs

sudo journalctl -fu binario.service
