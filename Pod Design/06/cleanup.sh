#!/bin/bash

# Delete the Pod
kubectl delete pod resource-pod -n ckad-scenario-15

# Delete the namespace
kubectl delete namespace ckad-scenario-15

echo "Cleanup complete. Your environment has been reset."
