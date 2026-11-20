# Practical

# 1. Install NGINX Ingress Controller

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl get pods -n ingress-nginx -o wide

# 2. Create different application services

kubectl create deployment app1 --image=nginx

kubectl create deployment app2 --image=httpd

# 2. Create ClusterIP services

kubectl expose deployment app1 --port=80

kubectl expose deployment app2 --port=80

# 3. Create ingress.yaml

vi ingress.yaml

apiVersion: networking.k8s.io/v1

kind: Ingress

metadata:

  name: my-ingress
  
spec:

  ingressClassName: nginx
  
  rules:
  
    - host: app1.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: app1
                port:
                  number: 80

    - host: app2.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: app2
                port:
                  number: 80

# 4. Create Ingress

kubectl apply -f ingress.yaml

# 5. Configure Host File

sudo vi /etc/hosts

127.0.0.1 app1.local

127.0.0.1 app2.local

# 6. Access applications
                  
http://app1.local/

http://app2.local/
