#!/bin/bash

# Delete the Pods
kubectl delete pod logging-pod -n ckad-scenario-7
kubectl delete pod log-reader -n ckad-scenario-7

# Delete the namespace
kubectl delete namespace ckad-scenario-7

echo "Cleanup complete. Your environment has been reset."
