### Scenario 2: Configuring Liveness and Readiness Probes

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-11

# Deploy a sample application with liveness and readiness probes
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: probes-deployment
  namespace: ckad-scenario-11
spec:
  replicas: 3
  selector:
    matchLabels:
      app: probes-app
  template:
    metadata:
      labels:
        app: probes-app
    spec:
      containers:
      - name: nginx
        image: nginx
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `probes-deployment` is running in the `ckad-scenario-11` namespace.
2. Inspect the `livenessProbe` and `readinessProbe` configurations.
3. Induce a failure in the liveness probe and observe the Pod's behavior.
4. Induce a failure in the readiness probe and observe the Pod's behavior.

##### Solution

1. Verify that the `probes-deployment` is running:
   ```sh
   kubectl get deployment probes-deployment -n ckad-scenario-11
   kubectl get pods -l app=probes-app -n ckad-scenario-11
   ```

2. Inspect the `livenessProbe` and `readinessProbe` configurations:
   ```sh
   kubectl describe deployment probes-deployment -n ckad-scenario-11
   ```

3. Induce a failure in the liveness probe by updating the Pod's configuration:
   ```sh
   kubectl edit deployment probes-deployment -n ckad-scenario-11
   # Modify the livenessProbe path to /invalid-path
   ```

4. Induce a failure in the readiness probe by updating the Pod's configuration:
   ```sh
   kubectl edit deployment probes-deployment -n ckad-scenario-11
   # Modify the readinessProbe path to /invalid-path
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment
kubectl delete deployment probes-deployment -n ckad-scenario-11

# Delete the namespace
kubectl delete namespace ckad-scenario-11

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Configure Liveness and Readiness Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

---
