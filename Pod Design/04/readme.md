### Scenario 4: Deploying a Stateful Application with Persistent Storage

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-13

# Create a PersistentVolume and PersistentVolumeClaim
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: ckad-scenario-13
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

# Deploy a StatefulSet using the PVC
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
  namespace: ckad-scenario-13
spec:
  selector:
    matchLabels:
      app: nginx
  serviceName: "nginx"
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the StatefulSet named `web` is running in the `ckad-scenario-13` namespace.
2. Inspect the PersistentVolumeClaims created by the StatefulSet.
3. Scale the StatefulSet to 5 replicas and verify that the PVCs are created and bound.

##### Solution

1. Verify that the StatefulSet named `web` is running:
   ```sh
   kubectl get statefulset web -n ckad-scenario-13
   kubectl get pods -l app=nginx -n ckad-scenario-13
   ```

2. Inspect the PersistentVolumeClaims created by the StatefulSet:
   ```sh
   kubectl get pvc -n ckad-scenario-13
   ```

3. Scale the StatefulSet to 5 replicas and verify the PVCs:
   ```sh
   kubectl scale statefulset web --replicas=5 -n ckad-scenario-13
   kubectl get pvc -n ckad-scenario-13
   kubectl get pods -l app=nginx -n ckad-scenario-13
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the StatefulSet
kubectl delete statefulset web -n ckad-scenario-13

# Delete the PersistentVolumeClaim
kubectl delete pvc www-web-0 -n ckad-scenario-13
kubectl delete pvc www-web-1 -n ckad-scenario-13
kubectl delete pvc www-web-2 -n ckad-scenario-13
kubectl delete pvc www-web-3 -n ckad-scenario-13
kubectl delete pvc www-web-4 -n ckad-scenario-13

# Delete the PersistentVolume
kubectl delete pv pv

# Delete the namespace
kubectl delete namespace ckad-scenario-13

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

---
