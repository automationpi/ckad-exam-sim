### Scenario 4: Configuring Ingress Resources

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-20

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-20
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
  namespace: ckad-scenario-20
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF

# Create an Ingress resource to expose the web application
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  namespace: ckad-scenario-20
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: web.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `web-deployment`, `web-service`, and `web-ingress` are created in the `ckad-scenario-20` namespace.
2. Configure your local `/etc/hosts` file to resolve `web.example.com` to the Ingress controller's IP address.
3. Use `curl` to access the web application via the Ingress resource.

##### Solution

1. Verify that the `web-deployment`, `web-service`, and `web-ingress` are created:
   ```sh
   kubectl get deployment web-deployment -n ckad-scenario-20
   kubectl get service web-service -n ckad-scenario-20
   kubectl get ingress web-ingress -n ckad-scenario-20
   ```

2. Configure your local `/etc/hosts` file:
   ```sh
   # Get the Ingress controller's IP address
   kubectl get ingress web-ingress -n ckad-scenario-20
   # Add the following line to your /etc/hosts file
   <ingress-ip> web.example.com
   ```

3. Use `curl` to access the web application via the Ingress resource:
   ```sh
   curl http://web.example.com
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment, Service, and Ingress
kubectl delete deployment web-deployment -n ckad-scenario-20
kubectl delete service web-service -n ckad-scenario-20
kubectl delete ingress web-ingress -n ckad-scenario-20

# Delete the namespace
kubectl delete namespace ckad-scenario-20

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

---
