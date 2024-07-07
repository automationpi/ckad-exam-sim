#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-16

# Deploy a sample application with Pod Affinity
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: affinity-deployment
  namespace: ckad-scenario-16
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - nginx
            topologyKey: "kubernetes.io/hostname"
      containers:
      - name: nginx
        image: nginx
EOF

echo "Setup complete. Your environment is ready."
