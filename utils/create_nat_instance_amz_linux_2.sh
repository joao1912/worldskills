# Pegar o nome da interface de rede primaria, algo como: eth0

ip a

# Ativar o encaminhamento de pacotes IP de uma interface para outra (roteamento).

echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf

# Salvar a config permanentemente

sudo sysctl -p

# Cria uma regra que faz os pacotes saírem pela interface de rede com o IP mascarado, permitindo o acesso à internet.

sudo iptables -t nat -A POSTROUTING -o <nome-interface-rede> -s 0.0.0.0/0 -j MASQUERADE

# Salva as regras permanentemente

sudo iptables-save | sudo tee /etc/sysconfig/iptables

# (iptables-services) é um serviço que lê o arquivo salvo e aplica as regras no boot.

sudo yum install iptables-services -y
sudo systemctl enable iptables
sudo systemctl start iptables

# Depois disso, precisa ir no console do ec2 e siga isso: EC2 → seleciono a instância → Actions → Networking → Change source/destination check e marca a checkbox 'stop'.
# Isso precisa ser feito ou a AWS vai bloquear os pacotes roteados que é o padrão.