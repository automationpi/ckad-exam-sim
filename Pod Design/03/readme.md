### Scenario 3: Using Selectors and ReplicaSets

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-12

# Deploy a sample ReplicaSet with label selectors
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-replicaset
  namespace: ckad-scenario-12
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: nginx
        image: nginx
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `myapp-replicaset` is running in the `ckad-scenario-12` namespace.
2. Scale the ReplicaSet to 5 replicas and verify the change.
3. Update the ReplicaSet to use a different image version and verify the update.

##### Solution

1. Verify that the `myapp-replicaset` is running:
   ```sh
   kubectl get replicaset myapp-replicaset -n ckad-scenario-12
   kubectl get pods -l app=myapp -n ckad-scenario-12
   ```

2. Scale the ReplicaSet to 5 replicas:
   ```sh
   kubectl scale replicaset myapp-replicaset --replicas=5 -n ckad-scenario-12
   kubectl get pods -l app=myapp -n ckad-scenario-12
   ```

3. Update the ReplicaSet to use a different image version:
   ```sh
   kubectl edit replicaset myapp-replicaset -n ckad-scenario-12
   # Change the image to nginx:1.19
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the ReplicaSet
kubectl delete replicaset myapp-replicaset -n ckad-scenario-12

# Delete the namespace
kubectl delete namespace ckad-scenario-12

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [ReplicaSets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

---
