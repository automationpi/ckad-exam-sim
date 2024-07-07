#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-5

# Deploy a sample application with an ambassador container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: ambassador-pod
  namespace: ckad-scenario-5
spec:
  containers:
  - name: main-app
    image: nginx
    ports:
    - containerPort: 80
  - name: ambassador
    image: busybox
    command: ['sh', '-c', 'while true; do nc -l -p 8080 -c "echo HTTP/1.1 200 OK; echo; echo Ambassador container response"; done']
    ports:
    - containerPort: 8080
EOF

echo "Setup complete. Your environment is ready."
