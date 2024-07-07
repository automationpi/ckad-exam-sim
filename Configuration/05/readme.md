
### Scenario 2: Create and Use Custom StorageClass

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-2

# Create a custom StorageClass
kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Create a PersistentVolume named `fast-pv` with 1Gi of storage, using the `fast-storage` StorageClass.
2. Create a PersistentVolumeClaim named `fast-pvc` in the `ckad-scenario-2` namespace that uses the `fast-storage` StorageClass.
3. Verify that the PersistentVolume is bound to the PersistentVolumeClaim.
4. Create a Pod named `storage-pod` that uses the `fast-pvc` PersistentVolumeClaim and mounts it at `/data`.

##### Solution

1. Create a PersistentVolume named `fast-pv`:
   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: fast-pv
   spec:
     capacity:
       storage: 1Gi
     accessModes:
     - ReadWriteOnce
     storageClassName: fast-storage
     local:
       path: /mnt/disks/ssd1
     nodeAffinity:
       required:
         nodeSelectorTerms:
         - matchExpressions:
           - key: kubernetes.io/hostname
             operator: In
             values:
             - node1
   ```
   ```sh
   kubectl apply -f fast-pv.yaml
   ```

2. Create a PersistentVolumeClaim named `fast-pvc`:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: fast-pvc
     namespace: ckad-scenario-2
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
     storageClassName: fast-storage
   ```
   ```sh
   kubectl apply -f fast-pvc.yaml
   ```

3. Verify that the PersistentVolume is bound to the PersistentVolumeClaim:
   ```sh
   kubectl get pvc fast-pvc -n ckad-scenario-2
   kubectl get pv fast-pv
   ```

4. Create a Pod named `storage-pod` that uses the `fast-pvc` PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: storage-pod
     namespace: ckad-scenario-2
   spec:
     containers:
     - name: nginx
       image: nginx
       volumeMounts:
       - mountPath: "/data"
         name: fast-storage
     volumes

:
     - name: fast-storage
       persistentVolumeClaim:
         claimName: fast-pvc
   ```
   ```sh
   kubectl apply -f storage-pod.yaml
   kubectl get pod storage-pod -n ckad-scenario-2
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod storage-pod -n ckad-scenario-2

# Delete the PersistentVolumeClaim
kubectl delete pvc fast-pvc -n ckad-scenario-2

# Delete the PersistentVolume
kubectl delete pv fast-pv

# Delete the StorageClass
kubectl delete storageclass fast-storage

# Delete the namespace
kubectl delete namespace ckad-scenario-2

echo "Cleanup complete. Your environment has been reset."
```

---
