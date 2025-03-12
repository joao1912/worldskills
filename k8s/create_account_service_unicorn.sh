# Precisa ativar isso antes

eksctl utils associate-iam-oidc-provider \
  --region us-east-1 \
  --cluster unicorn \
  --approve


# Para o comando funcionar, deve ter somente a policy pronta, o resto(iam e ServiceAccount) ele cria sozinho, depois é só assiciar essa ServiceAccount a algum serviço como pod.

eksctl create iamserviceaccount --name my-service-account --namespace default --cluster my-cluster --role-name my-role \
    --attach-policy-arn arn:aws:iam::111122223333:policy/my-policy --approve
