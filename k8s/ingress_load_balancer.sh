apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: unicorn-ingress
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    # alb.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: alb
  rules:
    - http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: service21
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: service2
                port:
                  number: 80

