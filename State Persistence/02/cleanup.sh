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
