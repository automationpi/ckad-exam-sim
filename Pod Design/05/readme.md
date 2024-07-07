### Scenario 5: Using Init Containers

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-14

# Deploy a sample application with an Init Container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: init-pod
  namespace: ckad-scenario-14
spec:
  initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'echo "Initializing" && sleep 5']
  containers:
  - name: myapp
    image: nginx
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the Pod named `init-pod` is running in the `ckad-scenario-14` namespace.
2. Inspect the logs of the Init Container to ensure it ran successfully.
3. Modify the Init Container to fail and observe the behavior of the main container.

##### Solution

1. Verify that the Pod named `init-pod` is running:
   ```sh
   kubectl get pod init-pod -n ckad-scenario-14
   ```

2. Inspect the logs of the Init Container:
   ```sh
   kubectl logs init-pod -c init-myservice -n ckad-scenario-14
   ```

3. Modify the Init Container to fail:
   ```sh
   kubectl edit pod init-pod -n ckad-scenario-14
   # Change the command to ['sh', '-c', 'echo "Failing" && exit 1']
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod init-pod -n ckad-scenario-14

# Delete the namespace
kubectl delete namespace ckad-scenario-14

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)

---
