#!/bin/bash
set -euxo pipefail

# Redirect output to user-data.log and console for easy debugging
exec > >(tee -a /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

export DEBIAN_FRONTEND=noninteractive

# Update package index and install Nginx
apt-get update -y
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

# Install Docker
apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group if user exists
if id "ubuntu" &>/dev/null; then
  usermod -aG docker ubuntu
fi

# Determine Architecture
ARCH=$(uname -m)

# Install Kind
if [ "$ARCH" = "x86_64" ]; then
  curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
  chmod +x /usr/local/bin/kind
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
  chmod +x /usr/local/bin/kind
fi

# Install kubectl
if ! command -v kubectl &>/dev/null; then
  echo "Installing kubectl..."
  VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt)

  if [ "$ARCH" = "x86_64" ]; then
    curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl"
  fi

  chmod +x /usr/local/bin/kubectl
  echo "kubectl installed successfully."
fi

# Create Kind 2-Node Cluster Configuration (1 control-plane, 1 worker)
cat <<EOF > /tmp/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
EOF

# Create Kind Kubernetes 2-Node cluster
echo "Creating Kind 2-Node Kubernetes cluster..."
if id "ubuntu" &>/dev/null; then
  # Create cluster as ubuntu user so kubeconfig is configured in /home/ubuntu/.kube/config
  sudo -u ubuntu kind create cluster --name dev-cluster --config /tmp/kind-config.yaml
  # Copy kubeconfig to root so root user can also run kubectl commands
  mkdir -p /root/.kube
  cp /home/ubuntu/.kube/config /root/.kube/config
else
  kind create cluster --name dev-cluster --config /tmp/kind-config.yaml
fi
echo "Kind 2-node cluster created successfully."