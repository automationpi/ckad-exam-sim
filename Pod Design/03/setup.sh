#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-12

# Deploy a sample ReplicaSet with label selectors
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-replicaset
  namespace: ckad-scenario-12
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: nginx
        image: nginx
EOF

echo "Setup complete. Your environment is ready."
