# TAGS PARA SUBNET PUB
# (tag) = kubernetes.io/role/elb | (valor) = 1
#
# TAGS PARA SUBNET PRIV
# 
# (tag) = kubernetes.io/role/internal-elb | (valor) = 1

# policy para o elb-ingress = https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json

# se for criar a policy via cli:
# APENAS SE NECESSARIO
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# criar serviceaccount

eksctl create iamserviceaccount \
  --cluster=my-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::111122223333:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

# add repo

helm repo add eks https://aws.github.io/eks-charts

# update repo

helm repo update eks

# intalar

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

# verificar

kubectl get deployment -n kube-system aws-load-balancer-controller
