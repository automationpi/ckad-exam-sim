### Scenario 2: Configuring Network Policies

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-18

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-18
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
  namespace: ckad-scenario-18
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF

# Create a default deny NetworkPolicy
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: ckad-scenario-18
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the `web-deployment`, `web-service`, and `default-deny` NetworkPolicy are created in the `ckad-scenario-18` namespace.
2. Create a new Pod in the same namespace and use `curl` to access the web application via the Service. Verify that the access is denied.
3. Create a new NetworkPolicy to allow traffic from the `curl-pod` to the `web-deployment`.

##### Solution

1. Verify that the `web-deployment`, `web-service`, and `default-deny` NetworkPolicy are created:
   ```sh
   kubectl get deployment web-deployment -n ckad-scenario-18
   kubectl get service web-service -n ckad-scenario-18
   kubectl get networkpolicy default-deny -n ckad-scenario-18
   ```

2. Create a new Pod and use `curl` to access the web application:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: curl-pod
     namespace: ckad-scenario-18
   spec:
     containers:
     - name: curl
       image: curlimages/curl
       command: ['sh', '-c', 'sleep 3600']
   ```
   ```sh
   kubectl apply -f curl-pod.yaml
   kubectl exec -it curl-pod -n ckad-scenario-18 -- curl web-service:80
   # Verify that the access is denied
   ```

3. Create a new NetworkPolicy to allow traffic from the `curl-pod` to the `web-deployment`:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-curl
     namespace: ckad-scenario-18
   spec:
     podSelector:
       matchLabels:
         app: web
     ingress:
     - from:
       - podSelector:
           matchLabels:
             run: curl-pod
       ports:
       - protocol: TCP
         port: 80
   ```
   ```sh
   kubectl apply -f allow-curl.yaml
   kubectl exec -it curl-pod -n ckad-scenario-18 -- curl web-service:80
   # Verify that the access is now allowed
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Deployment, Service, and NetworkPolicies
kubectl delete deployment web-deployment -n ckad-scenario-18
kubectl delete service web-service -n ckad-scenario-18
kubectl delete networkpolicy default-deny -n ckad-scenario-18
kubectl delete networkpolicy allow-curl -n ckad-scenario-18
kubectl delete pod curl-pod -n ckad-scenario-18

# Delete the namespace
kubectl delete namespace ckad-scenario-18

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

---
