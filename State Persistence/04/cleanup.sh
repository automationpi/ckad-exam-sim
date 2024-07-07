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
