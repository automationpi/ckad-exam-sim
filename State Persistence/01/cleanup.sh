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
