# Create Kind Cluster

# Step 1. Install prerequisites
sudo apt update
sudo apt upgrade -y

sudo apt install -y curl wget apt-transport-https ca-certificates

# Step 2. Install Docker
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER

newgrp docker
docker ps
docker version

# Step 3. Download & Install KIND
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.33.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
kind version

# Step 4. Install kubectl
sudo snap install kubectl --classic
kubectl version --client

# Step 5. Create a 3-node cluster configuration

# 1) vi kind-cluster.yaml

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4

nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP

      - containerPort: 443
        hostPort: 443
        protocol: TCP

  - role: worker
  - role: worker

# 2) kind create cluster --name dev-cluster --config kind-cluster.yaml

# Practical

# 1. Install NGINX Ingress Controller

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# 2. Create different application services

kubectl create deployment app1 --image=nginx
kubectl create deployment app2 --image=httpd

# 2. Create ClusterIP services

kubectl expose deployment app1 --port=80
kubectl expose deployment app2 --port=80

# 3. vi ingress.yaml

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

# 4. kubectl apply -f ingress.yaml

# 5. sudo vi /etc/hosts

127.0.0.1 app1.local
127.0.0.1 app2.local

# 6. Access applications
                  







