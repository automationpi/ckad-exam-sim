#!/bin/bash

# Delete the Pods
kubectl delete pod sidecar-pod -n ckad-scenario-4
kubectl delete pod log-reader -n ckad-scenario-4

# Delete the namespace
kubectl delete namespace ckad-scenario-4

echo "Cleanup complete. Your environment has been reset."
