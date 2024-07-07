### Scenario 1: Using Labels, Selectors, and Annotations

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-10

# Deploy a sample application with labels and annotations
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: labeled-pod
  namespace: ckad-scenario-10
  labels:
    app: myapp
    env: dev
  annotations:
    description: "This is a sample pod with labels and annotations"
spec:
  containers:
  - name: nginx
    image: nginx
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the Pod named `labeled-pod` is running in the `ckad-scenario-10` namespace.
2. Use `kubectl get` with label selectors to list the Pod.
3. Add an additional label to the running Pod.
4. Add an annotation to the running Pod.

##### Solution

1. Verify that the Pod named `labeled-pod` is running:
   ```sh
   kubectl get pod labeled-pod -n ckad-scenario-10
   ```

2. Use `kubectl get` with label selectors to list the Pod:
   ```sh
   kubectl get pods -l app=myapp -n ckad-scenario-10
   kubectl get pods -l env=dev -n ckad-scenario-10
   ```

3. Add an additional label to the running Pod:
   ```sh
   kubectl label pod labeled-pod version=v1 -n ckad-scenario-10
   kubectl get pods --show-labels -n ckad-scenario-10
   ```

4. Add an annotation to the running Pod:
   ```sh
   kubectl annotate pod labeled-pod author="devops team" -n ckad-scenario-10
   kubectl get pods --show-labels --show-annotations -n ckad-scenario-10
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod labeled-pod -n ckad-scenario-10

# Delete the namespace
kubectl delete namespace ckad-scenario-10

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
- [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)

---
