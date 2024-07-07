#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-2

# Create a custom StorageClass
kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

echo "Setup complete. Your environment is ready."
