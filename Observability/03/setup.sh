#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-9

# Deploy a sample application with a deliberate error
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: faulty-deployment
  namespace: ckad-scenario-9
spec:
  replicas: 3
  selector:
    matchLabels:
      app: faulty-app
  template:
    metadata:
      labels:
        app: faulty-app
    spec:
      containers:
      - name: faulty-app
        image: busybox
        command: ['sh', '-c', 'exit 1']
EOF

echo "Setup complete. Your environment is ready."
