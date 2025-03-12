helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

kubectl create namespace nginx-ingress

helm install ingress-nginx ingress-nginx/ingress-nginx \
--namespace nginx-ingress \
--set controller.metrics.enabled=true \
--set-string controller.metrics.service.annotations."prometheus\.io/port"="10254" \
--set-string controller.metrics.service.annotations."prometheus\.io/scrape"="true"
