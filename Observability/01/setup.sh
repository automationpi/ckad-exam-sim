#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-7

# Deploy a sample application with a logging sidecar container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: logging-pod
  namespace: ckad-scenario-7
spec:
  containers:
  - name: main-app
    image: nginx
    ports:
    - containerPort: 80
  - name: logger
    image: busybox
    command: ['sh', '-c', 'tail -f /var/log/nginx/access.log']
    volumeMounts:
    - name: log-volume
      mountPath: /var/log/nginx
  volumes:
  - name: log-volume
    emptyDir: {}
EOF

echo "Setup complete. Your environment is ready."
