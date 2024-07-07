### Scenario 3: Troubleshooting Application Failures

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-9

# Deploy a sample application with a deliberate error
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: faulty-deployment
  namespace: ckad-scenario-9
spec:
  replicas: 3
  selector:
    matchLabels:
      app: faulty-app
  template:
    metadata:
      labels:
        app: faulty-app
    spec:
      containers:
      - name: faulty-app
        image: busybox
        command: ['sh', '-c', 'exit 1']
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `faulty-deployment` is not running properly in the `ckad-scenario-9` namespace.
2. Use `kubectl describe` and `kubectl logs` to identify the cause of the failure.
3. Modify the Deployment to fix the error and ensure the application runs successfully.

##### Solution

1. Verify that the `faulty-deployment` is not running properly:
   ```sh
   kubectl get deployment faulty-deployment -n ckad-scenario-9
   ```

2. Use `kubectl describe` and `kubectl logs` to identify the cause of the failure:
   ```sh
   kubectl describe pod -l app=faulty-app -n ckad-scenario-9
   kubectl logs -l app=faulty-app -n ckad-scenario-9
   ```

3. Modify the Deployment to fix the error:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: faulty-deployment
     namespace: ckad-scenario-9
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: faulty-app
     template:
       metadata:
         labels:
           app: faulty-app
       spec:
         containers:
         - name: faulty-app
           image: busybox
           command: ['sh', '-c', 'while true; do echo "Running"; sleep 10; done']
   ```
   ```sh
   kubectl apply -f faulty-deployment.yaml
   kubectl get deployment faulty-deployment -n ckad-scenario-9
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment


kubectl delete deployment faulty-deployment -n ckad-scenario-9

# Delete the namespace
kubectl delete namespace ckad-scenario-9

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Troubleshooting](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/)

---
