# Pacote

curl -o ./aws-discovery-agent.tar.gz https://s3-us-west-2.amazonaws.com/aws-discovery-agent.us-west-2/linux/latest/aws-discovery-agent.tar.gz

# Descompactar

tar -xzf aws-discovery-agent.tar.gz

# Executar

sudo bash install -r "us-east-1" -k "AWS_KEY_ID" -s "AWS_KEY_SECRET"

