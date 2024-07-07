### Scenario 6: Configuring Resource Requests and Limits

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-15

# Deploy a sample application with resource requests and limits
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: ckad-scenario-15
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the Pod named `resource-pod` is running in the `ckad-scenario-15` namespace.
2. Inspect the resource requests and limits for the Pod.
3. Modify the resource limits to observe the effect on the running Pod.

##### Solution

1. Verify that the Pod named `resource-pod` is running:
   ```sh
   kubectl get pod resource-pod -n ckad-scenario-15
   ```

2. Inspect the resource requests and limits for the Pod:
   ```sh
   kubectl describe pod resource-pod -n ckad-scenario-15
   ```

3. Modify the resource limits:
   ```sh
   kubectl edit pod resource-pod -n ckad-scenario-15
   # Change the limits to memory: "256Mi" and cpu: "1"
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod resource-pod -n ckad-scenario-15

# Delete the namespace
kubectl delete namespace ckad-scenario-15

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

---
