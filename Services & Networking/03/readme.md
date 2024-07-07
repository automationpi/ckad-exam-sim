### Scenario 3: Configuring LoadBalancer and NodePort Services

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-19

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-19
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

# Create a LoadBalancer Service to expose the web application
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: web-loadbalancer
  namespace: ckad-scenario-19
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `web-deployment` and `web-loadbalancer` Service are created in the `ckad-scenario-19` namespace.
2. Get the external IP address of the LoadBalancer Service and use `curl` to access the web application.
3. Create a NodePort Service to expose the web application and use `curl` to access it via the node's IP

 and the NodePort.

##### Solution

1. Verify that the `web-deployment` and `web-loadbalancer` Service are created:
   ```sh
   kubectl get deployment web-deployment -n ckad-scenario-19
   kubectl get service web-loadbalancer -n ckad-scenario-19
   ```

2. Get the external IP address of the LoadBalancer Service and use `curl` to access the web application:
   ```sh
   kubectl get service web-loadbalancer -n ckad-scenario-19
   # Note the external IP and use curl to access the web application
   curl http://<external-ip>
   ```

3. Create a NodePort Service to expose the web application:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: web-nodeport
     namespace: ckad-scenario-19
   spec:
     selector:
       app: web
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
         nodePort: 30080
     type: NodePort
   ```
   ```sh
   kubectl apply -f web-nodeport.yaml
   # Get the node's IP and use curl to access the web application
   kubectl get nodes -o wide
   curl http://<node-ip>:30080
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment and Services
kubectl delete deployment web-deployment -n ckad-scenario-19
kubectl delete service web-loadbalancer -n ckad-scenario-19
kubectl delete service web-nodeport -n ckad-scenario-19

# Delete the namespace
kubectl delete namespace ckad-scenario-19

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)

---
