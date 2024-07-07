### Services & Networking (13%)

This section focuses on understanding and configuring networking, as well as creating and managing network policies in Kubernetes.

### Scenario 1: Configuring Cluster Networking with Services

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-17

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-17
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
EOF

# Create a ClusterIP Service to expose the web application
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: ckad-scenario-17
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `web-deployment` is running and the `web-service` is created in the `ckad-scenario-17` namespace.
2. Get the details of the Service and describe its endpoints.
3. Create a new Pod in the same namespace and use `curl` to access the web application via the Service.

##### Solution

1. Verify that the `web-deployment` and `web-service` are running:
   ```sh
   kubectl get deployment web-deployment -n ckad-scenario-17
   kubectl get service web-service -n ckad-scenario-17
   ```

2. Get the details of the Service and describe its endpoints:
   ```sh
   kubectl get service web-service -n ckad-scenario-17
   kubectl describe service web-service -n ckad-scenario-17
   ```

3. Create a new Pod and use `curl` to access the web application:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: curl-pod
     namespace: ckad-scenario-17
   spec:
     containers:
     - name: curl
       image: curlimages/curl
       command: ['sh', '-c', 'sleep 3600']
   ```
   ```sh
   kubectl apply -f curl-pod.yaml
   kubectl exec -it curl-pod -n ckad-scenario-17 -- curl web-service:80
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment and Service
kubectl delete deployment web-deployment -n ckad-scenario-17
kubectl delete service web-service -n ckad-scenario-17
kubectl delete pod curl-pod -n ckad-scenario-17

# Delete the namespace
kubectl delete namespace ckad-scenario-17

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)

---
