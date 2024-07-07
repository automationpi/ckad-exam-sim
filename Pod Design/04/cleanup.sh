#!/bin/bash

# Delete the StatefulSet
kubectl delete statefulset web -n ckad-scenario-13

# Delete the PersistentVolumeClaim
kubectl delete pvc www-web-0 -n ckad-scenario-13
kubectl delete pvc www-web-1 -n ckad-scenario-13
kubectl delete pvc www-web-2 -n ckad-scenario-13
kubectl delete pvc www-web-3 -n ckad-scenario-13
kubectl delete pvc www-web-4 -n ckad-scenario-13

# Delete the PersistentVolume
kubectl delete pv pv

# Delete the namespace
kubectl delete namespace ckad-scenario-13

echo "Cleanup complete. Your environment has been reset."
