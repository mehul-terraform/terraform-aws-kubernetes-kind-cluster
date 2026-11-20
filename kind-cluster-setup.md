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

vi kind-cluster.yaml

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

kind create cluster --name dev-cluster --config kind-cluster.yaml
