### Exercise 1: Basic Kubernetes API Primitives

#### Objective
In this exercise, you will practice using basic Kubernetes API primitives, including creating and managing Pods, ReplicationControllers, and ReplicaSets.

#### Setup Script (`setup.sh`)

```sh
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
```

#### Scenario

You are required to create and manage basic Kubernetes API primitives. This includes creating and verifying the status of Pods, ReplicationControllers, and ReplicaSets.

##### Steps

1. Create a namespace `ckad-exercise-1`.
2. Create a Pod named `nginx-pod` using the Nginx image.
3. Create a ReplicationController named `nginx-rc` with 3 replicas using the Nginx image.
4. Create a ReplicaSet named `nginx-rs` with 3 replicas using the Nginx image.
5. Verify the status of the Pod, ReplicationController, and ReplicaSet.

#### Verification

- Check the status of the Pod to ensure it is running.
- Confirm the ReplicationController is managing 3 replicas.
- Verify the ReplicaSet is managing 3 replicas.

#### Cleanup Script (`cleanup.sh`)

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod nginx-pod -n ckad-exercise-1

# Delete the ReplicationController
kubectl delete rc nginx-rc -n ckad-exercise-1

# Delete the ReplicaSet
kubectl delete rs nginx-rs -n ckad-exercise-1

# Delete the namespace
kubectl delete namespace ckad-exercise-1

echo "Cleanup complete. Your environment has been reset."
```

#### Documentation and Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
- [ReplicationControllers](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/)
- [ReplicaSets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

#### Expectations

- Understand how to create and manage Kubernetes Pods.
- Gain experience in working with ReplicationControllers and ReplicaSets.
- Learn to verify and troubleshoot basic Kubernetes API primitives.

---
