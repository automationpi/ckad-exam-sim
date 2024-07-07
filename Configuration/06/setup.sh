#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-3

# Apply a ResourceQuota
kubectl apply -f - <<EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: mem-cpu-quota
  namespace: ckad-scenario-3
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 1Gi
    limits.cpu: "4"
    limits.memory: 2Gi
EOF

echo "Setup complete. Your environment is ready."
