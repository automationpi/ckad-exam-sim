#!/bin/bash

# Delete the Pod
kubectl delete pod init-pod -n ckad-scenario-14

# Delete the namespace
kubectl delete namespace ckad-scenario-14

echo "Cleanup complete. Your environment has been reset."
