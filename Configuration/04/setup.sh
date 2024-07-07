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
