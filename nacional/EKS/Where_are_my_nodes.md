# Desafio — Where are my nodes

## Objetivo 1
Conectar-se à instância EC2 e preparar o ambiente para criação do cluster EKS.

## Passo a passo
1. Acesse o **Console AWS** e abra o serviço **EC2**.
2. Em **Instances**, selecione a instância que será utilizada para manipular o cluster **EKS**.
3. Clique em **Connect**.
4. Na aba **Session Manager**, clique em **Connect**.
5. No terminal, execute o comando `sudo su - ec2-user`.
6. Baixe o arquivo de configuração YAML do cluster com `wget https://link-file`.
7. Garanta que o arquivo baixado esteja configurado corretamente com a região e a versão do cluster.
8. Aguarde a criação do cluster ser concluída.

## Objetivo 2
Fazer com que os **nodes do EKS** sejam visíveis no Console AWS. *(incompleto)*

## Objetivo 3
Configurar um **Service Account** no cluster.

## Passo a passo
1. Ative o **OIDC** no cluster com `eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster cluster-name --approve`.
2. Crie o Service Account com `eksctl create iamserviceaccount --name my-service-account --namespace default --cluster my-cluster --role-name my-role --attach-policy-arn arn:aws:iam::111122223333:policy/my-policy --approve`.
3. Baixe o arquivo de deployment do bucket com `wget https://link-deployment`.
4. Edite o arquivo YAML de deployment no campo **serviceAccountName**, substituindo pelo Service Account criado anteriormente. *(incompleto)*
