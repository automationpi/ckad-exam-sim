#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-exercise-1

# Create a simple Pod
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: ckad-exercise-1
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
EOF

# Create a ReplicationController
kubectl apply -f - <<EOF
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-rc
  namespace: ckad-exercise-1
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

# Create a ReplicaSet
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
  namespace: ckad-exercise-1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

echo "Setup complete. Your environment is ready."
