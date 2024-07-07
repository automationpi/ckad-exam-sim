### Scenario 1: Configure PodSecurityPolicy and NetworkPolicy

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-1

# Create a PodSecurityPolicy
kubectl apply -f - <<EOF
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted-psp
spec:
  privileged: false
  allowPrivilegeEscalation: false
  runAsUser:
    rule: 'MustRunAsNonRoot'
  seLinux:
    rule: 'RunAsAny'
  supplementalGroups:
    rule: 'MustRunAs'
    ranges:
    - min: 1
      max: 65535
  fsGroup:
    rule: 'MustRunAs'
    ranges:
    - min: 1
      max: 65535
  volumes:
  - 'configMap'
  - 'emptyDir'
  - 'projected'
  - 'secret'
  - 'downwardAPI'
EOF

# Create a Role and RoleBinding to use the PodSecurityPolicy
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: psp-role
  namespace: ckad-scenario-1
rules:
- apiGroups:
  - policy
  resources:
  - podsecuritypolicies
  verbs:
  - use
  resourceNames:
  - restricted-psp
EOF

kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: psp-rolebinding
  namespace: ckad-scenario-1
subjects:
- kind: ServiceAccount
  name: default
  namespace: ckad-scenario-1
roleRef:
  kind: Role
  name: psp-role
  apiGroup: rbac.authorization.k8s.io
EOF

# Deploy a sample application
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: ckad-scenario-1
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: nginx
        ports:
        - containerPort: 80
EOF

# Create a NetworkPolicy to allow traffic only from specific pods
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-specific
  namespace: ckad-scenario-1
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: allowed
    ports:
    - protocol: TCP
      port: 80
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Create a Pod named `restricted-pod` that attempts to run as the root user. Verify that it is denied due to the PodSecurityPolicy.
2. Create a Pod named `allowed-pod` with the label `role=allowed` in the `ckad-scenario-1` namespace and verify that it can access the web application.
3. Create a Pod named `blocked-pod` without the label `role=allowed` in the `ckad-scenario-1` namespace and verify that it cannot access the web application.

##### Solution

1. Create a Pod named `restricted-pod` that attempts to run as the root user:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: restricted-pod
     namespace: ckad-scenario-1
   spec:
     containers:
     - name: nginx
       image: nginx
       securityContext:
         runAsUser: 0
   ```
   ```sh
   kubectl apply -f restricted-pod.yaml
   kubectl get pod restricted-pod -n ckad-scenario-1
   ```

2. Create a Pod named `allowed-pod` with the label `role=allowed`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: allowed-pod
     namespace: ckad-scenario-1
     labels:
       role: allowed
   spec:
     containers:
     - name: busybox
       image: busybox
       command: ['sh', '-c', 'sleep 3600']
   ```
   ```sh
   kubectl apply -f allowed-pod.yaml
   kubectl exec allowed-pod -n ckad-scenario-1 -- wget -qO- http://web-deployment
   ```

3. Create a Pod named `blocked-pod` without the label `role=allowed`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: blocked-pod
     namespace: ckad-scenario-1
   spec:
     containers:
     - name: busybox
       image: busybox
       command: ['sh', '-c', 'sleep 3600']
   ```
   ```sh
   kubectl apply -f blocked-pod.yaml
   kubectl exec blocked-pod -n ckad-scenario-1 -- wget -qO- http://web-deployment
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pods
kubectl delete pod restricted-pod -n ckad-scenario-1
kubectl delete pod allowed-pod -n ckad-scenario-1
kubectl delete pod blocked-pod -n ckad-scenario-1

# Delete the Deployment
kubectl delete deployment web-deployment -n ckad-scenario-1

# Delete the NetworkPolicy
kubectl delete networkpolicy allow-specific -n ckad-scenario-1

# Delete the PodSecurityPolicy
kubectl delete podsecuritypolicy restricted-psp

# Delete the Role and RoleBinding
kubectl delete role psp-role -n ckad-scenario-1
kubectl delete rolebinding psp-rolebinding -n ckad-scenario-1

# Delete the namespace
kubectl delete namespace ckad-scenario-1

echo "Cleanup complete. Your environment has been reset."
```

--
