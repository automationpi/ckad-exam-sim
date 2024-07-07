#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-4

# Deploy a sample application with a sidecar container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-pod
  namespace: ckad-scenario-4
spec:
  containers:
  - name: main-app
    image: nginx
    ports:
    - containerPort: 80
  - name: sidecar
    image: busybox
    command: ['sh', '-c', 'while true; do echo "Sidecar container is running" >> /var/log/sidecar.log; sleep 5; done']
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  volumes:
  - name: shared-logs
    emptyDir: {}
EOF

echo "Setup complete. Your environment is ready."
