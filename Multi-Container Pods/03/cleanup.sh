#!/bin/bash

# Delete the Pods
kubectl delete pod adapter-pod -n ckad-scenario-6
kubectl delete pod log-reader -n ckad-scenario-6

# Delete the namespace
kubectl delete namespace ckad-scenario-6

echo "Cleanup complete. Your environment has been reset."
