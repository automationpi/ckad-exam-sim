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
