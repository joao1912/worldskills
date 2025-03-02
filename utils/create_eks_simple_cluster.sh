eksctl create cluster \
  --name unicorn \
  --region us-east-1 \
  --nodegroup-name unicorn-nodes \
  --node-type t2.medium \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 1 \
  --vpc-private-subnets subnet-1,subnet-2 \
  --node-private-networking \
  --node-ami-family AmazonLinux2023

