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

# 1) Create kind-cluster.yaml file
kind-cluster.yaml

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

# 2) Create Cluster
kind create cluster --name dev-cluster --config kind-cluster.yaml

# 3) Create Pod, Deployment and Services

kubectl create deployment nginx --image=nginx

kubectl scale deployment nginx --replicas=3

kubectl expose deployment nginx --port=80 --type=NodePort

kubectl get deployments

kubectl get pods

kubectl get services

kubectl get nodes -o wide

curl http://[NODE-IP]:[PORT]

kubectl port-forward svc/nginx-service 8080:80 (Access From Root Host/Windows Machine)
