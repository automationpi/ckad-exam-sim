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

echo "Cleanup complete. Your environment has been reset."
