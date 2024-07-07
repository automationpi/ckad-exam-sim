### Scenario 7: Using Pod Affinity and Anti-Affinity

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-16

# Deploy a sample application with Pod Affinity
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: affinity-deployment
  namespace: ckad-scenario-16
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
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - nginx
            topologyKey: "kubernetes.io/hostname"
      containers:
      - name: nginx
        image: nginx
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `affinity-deployment` is running in the `ckad-scenario-16` namespace.
2. Inspect the Pod Affinity rules applied to the Pods.
3. Modify the Deployment to use Anti-Affinity rules and observe the Pod scheduling behavior.

##### Solution

1. Verify that the `affinity-deployment` is running:
   ```

sh
   kubectl get deployment affinity-deployment -n ckad-scenario-16
   kubectl get pods -l app=nginx -n ckad-scenario-16
   ```

2. Inspect the Pod Affinity rules:
   ```sh
   kubectl describe deployment affinity-deployment -n ckad-scenario-16
   ```

3. Modify the Deployment to use Anti-Affinity rules:
   ```sh
   kubectl edit deployment affinity-deployment -n ckad-scenario-16
   # Change podAffinity to podAntiAffinity
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment
kubectl delete deployment affinity-deployment -n ckad-scenario-16

# Delete the namespace
kubectl delete namespace ckad-scenario-16

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Pod Affinity and Anti-Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity)

---
