#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-14

# Deploy a sample application with an Init Container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: init-pod
  namespace: ckad-scenario-14
spec:
  initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'echo "Initializing" && sleep 5']
  containers:
  - name: myapp
    image: nginx
EOF

echo "Setup complete. Your environment is ready."
