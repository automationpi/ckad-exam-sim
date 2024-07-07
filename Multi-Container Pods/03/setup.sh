#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-6

# Deploy a sample application with an adapter container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: adapter-pod
  namespace: ckad-scenario-6
spec:
  containers:
  - name: main-app
    image: busybox
    command: ['sh', '-c', 'while true; do echo "main-app log entry" >> /var/log/main-app.log; sleep 5; done']
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  - name: adapter
    image: busybox
    command: ['sh', '-c', 'tail -f /var/log/main-app.log']
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  volumes:
  - name: shared-logs
    emptyDir: {}
EOF

echo "Setup complete. Your environment is ready."
