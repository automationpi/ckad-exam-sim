### Scenario 3: Configure and Validate Resource Quotas and Limits

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-3

# Apply a ResourceQuota
kubectl apply -f - <<EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: mem-cpu-quota
  namespace: ckad-scenario-3
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 1Gi
    limits.cpu: "4"
    limits.memory: 2Gi
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Create a Deployment named `quota-test` in the `ckad-scenario-3` namespace with 3 replicas of an Nginx container. Each container should request 0.5 CPU and 200Mi memory, and have a limit of 1 CPU and 500Mi memory.
2. Verify that the Deployment is created and all replicas are running.
3. Attempt to scale the Deployment to 5 replicas and observe the behavior due to resource quota constraints.

##### Solution

1. Create a Deployment named `quota-test` with 3 replicas:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: quota-test
     namespace: ckad-scenario-3
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
           resources:
             requests:
               cpu: "0.5"
               memory: "200Mi"
             limits:
               cpu: "1"
               memory: "500Mi"
           ports:
           - containerPort: 80
   ```
   ```sh
   kubectl apply -f quota-test.yaml
   ```

2. Verify that the Deployment is created and all replicas are running:
   ```sh
   kubectl get deployment quota-test -n ckad-scenario-3
   ```

3. Attempt to scale the Deployment to 5 replicas and observe the behavior:
   ```sh
   kubectl scale deployment quota-test --replicas=5 -n ckad-scenario-3
   kubectl get deployment quota-test -n ckad-scenario-3
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment
kubectl delete deployment quota-test -n ckad-scenario-3

# Delete the ResourceQuota
kubectl delete resourcequota mem-cpu-quota -n ckad-scenario-3

# Delete the namespace
kubectl delete namespace ckad-scenario-3

echo "Cleanup complete. Your environment has been reset."
```

---
