### Scenario 2: Implement Ambassador Pattern

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-5

# Deploy a sample application with an ambassador container
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: ambassador-pod
  namespace: ckad-scenario-5
spec:
  containers:
  - name: main-app
    image: nginx
    ports:
    - containerPort: 80
  - name: ambassador
    image: busybox
    command: ['sh', '-c', 'while true; do nc -l -p 8080 -c "echo HTTP/1.1 200 OK; echo; echo Ambassador container response"; done']
    ports:
    - containerPort: 8080
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the Pod named `ambassador-pod` is running in the `ckad-scenario-5` namespace.
2. Forward port 8080 of the `ambassador` container to your local machine and access it using a browser or curl to verify the response.
3. Create a Service to expose the `ambassador` container on port 8080 within the cluster.

##### Solution

1. Verify that the Pod named `ambassador-pod` is running:
   ```sh
   kubectl get pod ambassador-pod -n ckad-scenario-5
   ```

2. Forward port 8080 of the `ambassador` container and access it:
   ```sh
   kubectl port-forward pod/ambassador-pod 8080:8080 -n ckad-scenario-5
   ```
   Open a browser or use curl to access `http://localhost:8080`.

3. Create a Service to expose the `ambassador` container:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: ambassador-service
     namespace: ckad-scenario-5
   spec:
     selector:
       app: ambassador-pod
     ports:
     - protocol: TCP
       port: 8080
       targetPort: 8080
   ```
   ```sh
   kubectl apply -f ambassador-service.yaml
   kubectl get service ambassador-service -n ckad-scenario-5
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod ambassador-pod -n ckad-scenario-5

# Delete the Service
kubectl delete service ambassador-service -n ckad-scenario-5

# Delete the namespace
kubectl delete namespace ckad-scenario-5

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Ambassador Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/ambassador)

---
