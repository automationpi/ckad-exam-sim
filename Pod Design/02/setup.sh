#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-11

# Deploy a sample application with liveness and readiness probes
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: probes-deployment
  namespace: ckad-scenario-11
spec:
  replicas: 3
  selector:
    matchLabels:
      app: probes-app
  template:
    metadata:
      labels:
        app: probes-app
    spec:
      containers:
      - name: nginx
        image: nginx
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
EOF

echo "Setup complete. Your environment is ready."
