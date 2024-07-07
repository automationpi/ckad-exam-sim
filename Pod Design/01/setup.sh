#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-10

# Deploy a sample application with labels and annotations
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: labeled-pod
  namespace: ckad-scenario-10
  labels:
    app: myapp
    env: dev
  annotations:
    description: "This is a sample pod with labels and annotations"
spec:
  containers:
  - name: nginx
    image: nginx
EOF

echo "Setup complete. Your environment is ready."
