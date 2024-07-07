### State Persistence (8%)

This section focuses on configuring and managing persistent storage, as well as understanding storage classes and PersistentVolumeClaims in Kubernetes.

### Scenario 1: Configuring PersistentVolume and PersistentVolumeClaim

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-21

# Create a PersistentVolume
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

# Create a PersistentVolumeClaim
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: ckad-scenario-21
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that the PersistentVolume and PersistentVolumeClaim are created.
2. Create a Pod that uses the PersistentVolumeClaim to store data.
3. Verify that the Pod can read and write data to the PersistentVolume.

##### Solution

1. Verify that the PersistentVolume and PersistentVolumeClaim are created:
   ```sh
   kubectl get pv
   kubectl get pvc -n ckad-scenario-21
   ```

2. Create a Pod that uses the PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pvc-pod
     namespace: ckad-scenario-21
   spec:
     containers:
     - name: myapp
       image: busybox
       command: ['sh', '-c', 'while true; do echo $(date) >> /data/log.txt; sleep 5; done']
       volumeMounts:
       - mountPath: "/data"
         name: mypvc
     volumes:
     - name: mypvc
       persistentVolumeClaim:
         claimName: pvc
   ```
   ```sh
   kubectl apply -f pvc-pod.yaml
   kubectl get pod pvc-pod -n ckad-scenario-21
   ```

3. Verify that the Pod can read and write data to the PersistentVolume:
   ```sh
   kubectl exec -it pvc-pod -n ckad-scenario-21 -- cat /data/log.txt
   ```

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod pvc-pod -n ckad-scenario-21

# Delete the PersistentVolumeClaim
kubectl delete pvc pvc -n ckad-scenario-21

# Delete the PersistentVolume
kubectl delete pv pv

# Delete the namespace
kubectl delete namespace ckad-scenario-21

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

---
