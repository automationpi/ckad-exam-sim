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
