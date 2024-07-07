### Scenario 3: Using StatefulSets with Persistent Storage

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-23

# Create a StorageClass
kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

# Deploy a StatefulSet with Persistent Storage
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
  namespace: ckad-scenario-23
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
      storageClassName: fast-storage
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the StatefulSet named `web` is running in the `ckad-scenario-23` namespace.
2. Inspect the PersistentVolumeClaims created by the StatefulSet.
3. Scale the StatefulSet to 5 replicas and verify that the PVCs are created and bound.

##### Solution

1. Verify that the StatefulSet named `web` is running:
   ```sh
   kubectl get statefulset web -n ckad-scenario-23
   kubectl get pods -l app=nginx -n ckad-scenario-23
   ```

2. Inspect the PersistentVolumeClaims created by the StatefulSet:
   ```sh
   kubectl get pvc -n ckad-scenario-23
   ```

3. Scale the StatefulSet to 5 replicas and verify the PVCs:
   ```sh
   kubectl scale statefulset web --replicas=5 -n ckad-scenario-23
   kubectl get pvc -n ckad-scenario-23
   kubectl get pods -l app=nginx -n ckad-scenario-23
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the StatefulSet
kubectl delete statefulset web -n ckad-scenario-23

# Delete the PersistentVolumeClaims
kubectl delete pvc -l app=nginx -n ckad-scenario-23

# Delete the PersistentVolumes
kubectl delete pv $(kubectl get pv -o jsonpath='{.items[?(@.spec.claimRef.namespace=="ckad-scenario-23")].metadata.name}')

# Delete the StorageClass
kubectl delete storageclass fast-storage

# Delete the namespace
kubectl delete namespace ckad-scenario-23

echo "Cleanup complete.

 Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

---
