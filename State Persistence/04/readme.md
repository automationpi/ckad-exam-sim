### Scenario 4: Backing Up and Restoring Persistent Data

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-24

# Create a PersistentVolume and PersistentVolumeClaim
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-backup
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data-backup"
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-backup
  namespace: ckad-scenario-24
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

# Create a Pod to write data to the PersistentVolume
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: backup-pod
  namespace: ckad-scenario-24
spec:
  containers:
  - name: busybox
    image: busybox
    command: ['sh', '-c', 'echo "Backup data" > /data/backup.txt && sleep 3600']
    volumeMounts:
    - name: mypvc
      mountPath: /data
  volumes:
  - name: mypvc
    persistentVolumeClaim:
      claimName: pvc-backup
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the Pod named `backup-pod` is running and has written data to the PersistentVolume.
2. Back up the data from the PersistentVolume to a local directory.
3. Create a new PersistentVolume and PersistentVolumeClaim.
4. Restore the backed-up data to a new Pod using the new PersistentVolumeClaim.

##### Solution

1. Verify that the Pod named `backup-pod` is running and has written data:
   ```sh
   kubectl get pod backup-pod -n ckad-scenario-24
   kubectl exec -it backup-pod -n ckad-scenario-24 -- cat /data/backup.txt
   ```

2. Back up the data from the PersistentVolume:
   ```sh
   mkdir -p /mnt/backup
   kubectl cp ckad-scenario-24/backup-pod:/data/backup.txt /mnt/backup/backup.txt
   ```

3. Create a new PersistentVolume and PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: pv-restore
   spec:
     capacity:
       storage: 1Gi
     accessModes:
       - ReadWriteOnce
     hostPath:
       path: "/mnt/data-restore"
   ```
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-restore
     namespace: ckad-scenario-24
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
   ```
   ```sh
   kubectl apply -f pv-restore.yaml
   kubectl apply -f pvc-restore.yaml
   ```

4. Restore the backed-up data to a new Pod:
   ```sh
   kubectl apply -f - <<EOF
   apiVersion: v1
   kind: Pod
   metadata:
     name: restore-pod
     namespace: ckad-scenario-24
   spec:
     containers:
     - name: busybox
       image: busybox
       command: ['sh', '-c', 'cat /data/backup.txt && sleep 3600']
       volumeMounts:
       - name: mypvc
         mountPath: /data
     volumes:
     - name: mypvc
       persistentVolumeClaim:
         claimName: pvc-restore
   EOF
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pods
kubectl delete pod backup-pod -n ckad-scenario-24
kubectl delete pod restore-pod -n ckad-scenario-24

# Delete the PersistentVolumeClaims
kubectl delete pvc pvc-backup -n ckad-scenario-24
kubectl delete pvc pvc-restore -n ckad-scenario-24

# Delete the PersistentVolumes
kubectl delete pv pv-backup
kubectl delete pv pv-restore

# Delete the namespace
kubectl delete namespace ckad-scenario-24

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)

---
