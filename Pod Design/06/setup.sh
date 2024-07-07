#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-15

# Deploy a sample application with resource requests and limits
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: ckad-scenario-15
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
EOF

echo "Setup complete. Your environment is ready."
