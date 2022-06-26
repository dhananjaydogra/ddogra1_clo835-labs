#!/bin/bash
set -ex
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
cd /home/ec2-user/
sudo echo -e "curl -sLo kind https://kind.sigs.k8s.io/dl/v0.11.0/kind-linux-amd64\nsudo install -o root -g root -m 0755 kind /usr/local/bin/kind\nrm -f ./kind\ncurl -LO 'https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'\nsudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl\nrm -f ./kubectl\nkind create cluster --config kind.yaml" >> kind.sh
sudo echo -e "kind: Cluster\napiVersion: kind.x-k8s.io/v1alpha4\nnodes:\n- role: control-plane\n  image: kindest/node:v1.19.11@sha256:07db187ae84b4b7de440a73886f008cf903fcf5764ba8106a9fd5243d6f32729\n  extraPortMappings:\n  - containerPort: 30000\n    hostPort: 30000\n  - containerPort: 30001\n    hostPort: 30001\n  - containerPort: 8080\n    hostPort: 8080\n  - containerPort: 8081\n    hostPort: 8081" >> kind.yaml
