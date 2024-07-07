#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-18

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-18
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
EOF

# Create a ClusterIP Service to expose the web application
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: ckad-scenario-18
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF

# Create a default deny NetworkPolicy
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: ckad-scenario-18
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF

echo "Setup complete. Your environment is ready."
