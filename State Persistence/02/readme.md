### Scenario 2: Dynamic Provisioning with Storage Classes

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-22

# Create a StorageClass
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

1. Create a PersistentVolumeClaim using the `fast-storage` StorageClass.
2. Verify that a PersistentVolume is dynamically provisioned and bound to the PersistentVolumeClaim.
3. Create a Pod that uses the PersistentVolumeClaim to store data.

##### Solution

1. Create a PersistentVolumeClaim using the `fast-storage` StorageClass:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: fast-pvc
     namespace: ckad-scenario-22
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
   kubectl get pvc -n ckad-scenario-22
   ```

2. Verify that a PersistentVolume is dynamically provisioned and bound to the PersistentVolumeClaim:
   ```sh
   kubectl get pv
   kubectl get pvc -n ckad-scenario-22
   ```

3. Create a Pod that uses the PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: fast-pvc-pod
     namespace: ckad-scenario-22
   spec:
     containers:
     - name: myapp
       image: busybox
       command: ['sh', '-c', 'while true; do echo $(date) >> /data/log.txt; sleep 5; done']
       volumeMounts:
       - mountPath: "/data"
         name: fastpvc
     volumes:
     - name: fastpvc
       persistentVolumeClaim:
         claimName: fast-pvc
   ```
   ```sh
   kubectl apply -f fast-pvc-pod.yaml
   kubectl get pod fast-pvc-pod -n ckad-scenario-22
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod fast-pvc-pod -n ckad-scenario-22

# Delete the PersistentVolumeClaim
kubectl delete pvc fast-pvc -n ckad-scenario-22

# Delete the PersistentVolume
kubectl delete pv $(kubectl get pv -o jsonpath='{.items[?(@.spec.claimRef.name=="fast-pvc")].metadata.name}')

# Delete the StorageClass
kubectl delete storageclass fast-storage

# Delete the namespace
kubectl delete namespace ckad-scenario-22

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

---
